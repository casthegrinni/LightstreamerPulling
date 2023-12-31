//
//  Connector.swift
//  LightstreamerStocksPulling
//
//  Created by Brunno Castigrini on 30/06/23.
//

import Foundation
import LightstreamerClient

private var __sharedInstace: Connector? = nil
private let __lockQueue = DispatchQueue(label: "lightstreamer.Connector")

class Connector: NSObject, ClientDelegate {
    let client: LightstreamerClient

    // MARK: -
    // MARK: Properties

    var connected: Bool {
        return client.status.rawValue.hasPrefix("CONNECTED:")
    }

    var connectionStatus: String {
        return client.status.rawValue
    }

    // MARK: Singleton access
    @objc class func shared() -> Connector {
        if __sharedInstace == nil {
            __lockQueue.sync {
                if __sharedInstace == nil {
                    __sharedInstace = Connector()
                }
            }
        }

        return __sharedInstace!
    }
    
    @objc class func sharedConnector() -> Connector {
        Self.shared()
    }

    
    // MARK: Initialization
    override init() {
        client = LightstreamerClient(serverAddress: PUSH_SERVER_URL, adapterSet: ADAPTER_SET)
        super.init()
        client.addDelegate(self)
    }

    
    // MARK: Operations
    func connect() {
        print("Connector: connecting...")
        client.connect()
    }
    
    func disconnect() {
        print("Connector: disconnecting...")
        client.disconnect()
    }

    func subscribe(_ subscription: Subscription) {
        print("Connector: subscribing...")
        client.subscribe(subscription)
    }

    func unsubscribe(_ subscription: Subscription) {
        print("Connector: unsubscribing...")
        client.unsubscribe(subscription)
    }


    // MARK: Methods of ClientDelegate
    func clientDidRemoveDelegate(_ client: LightstreamerClient) {}
    func clientDidAddDelegate(_ client: LightstreamerClient) {}

    func client(_ client: LightstreamerClient, didChangeProperty property: String) {
        print("Connector: property changed: \(property)")
    }

    func client(_ client: LightstreamerClient, didChangeStatus status: LightstreamerClient.Status) {
        print("Connector: status changed: \(status)")
        let status = status.rawValue
        if status.hasPrefix("CONNECTED:") {
            NotificationCenter.default.post(name: NOTIFICATION_CONN_STATUS,
                                            object: nil,
                                            userInfo: [IS_CONNECTED: true])
        } else if status.hasPrefix("DISCONNECTED:") {
            NotificationCenter.default.post(name: NOTIFICATION_CONN_STATUS,
                                            object: nil,
                                            userInfo: [IS_CONNECTED: false])
        } else if status == "DISCONNECTED" {
            NotificationCenter.default.post(name: NOTIFICATION_CONN_STATUS,
                                            object: nil,
                                            userInfo: [IS_CONNECTED: false])
        }
    }

    func client(_ client: LightstreamerClient, didReceiveServerError errorCode: Int, withMessage errorMessage: String) {
        print(String(format: "Connector: server error: %ld - %@", errorCode, errorMessage))

        NotificationCenter.default.post(name: NOTIFICATION_CONN_STATUS,
                                        object: nil,
                                        userInfo: [IS_CONNECTED: false])
    }
}
