//
//  LightstreamerViewModel.swift
//  LightstreamerStocksPulling
//
//  Created by Brunno Castigrini on 30/06/23.
//

import SwiftUI
import LightstreamerClient

class LightstreamerViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    
    
    func connect() {
        
    }
    
    func disconnect() {
        
    }
}

extension LightstreamerViewModel: SubscriptionDelegate {
    func subscription(_ subscription: Subscription, didUpdateItem itemUpdate: ItemUpdate) {
        let stockName: String = itemUpdate.value(withFieldName: "last_price") ?? ""
        let lastPrice: Double = Double(itemUpdate.value(withFieldName: "last_price") ?? "0")!
        
        print("Stock name: \(stockName)\nLastPrice: \(lastPrice)")
    }
    
    func subscription(_ subscription: Subscription, didClearSnapshotForItemName itemName: String?, itemPos: UInt) {}
    func subscription(_ subscription: Subscription, didLoseUpdates lostUpdates: UInt, forCommandSecondLevelItemWithKey key: String) {}
    func subscription(_ subscription: Subscription, didFailWithErrorCode code: Int, message: String?, forCommandSecondLevelItemWithKey key: String) {}
    func subscription(_ subscription: Subscription, didEndSnapshotForItemName itemName: String?, itemPos: UInt) {}
    func subscription(_ subscription: Subscription, didLoseUpdates lostUpdates: UInt, forItemName itemName: String?, itemPos: UInt) {}
    func subscriptionDidRemoveDelegate(_ subscription: Subscription) {}
    func subscriptionDidAddDelegate(_ subscription: Subscription) {}
    func subscriptionDidSubscribe(_ subscription: Subscription) {}
    func subscription(_ subscription: Subscription, didFailWithErrorCode code: Int, message: String?) {}
    func subscriptionDidUnsubscribe(_ subscription: Subscription) {}
    func subscription(_ subscription: Subscription, didReceiveRealFrequency frequency: RealMaxFrequency?) {}
}

extension LightstreamerViewModel: ClientDelegate {
    func clientDidRemoveDelegate(_ client: LightstreamerClient) {
        
    }
    
    func clientDidAddDelegate(_ client: LightstreamerClient) {
        
    }
    
    func client(_ client: LightstreamerClient, didReceiveServerError errorCode: Int, withMessage errorMessage: String) {
        
    }
    
    func client(_ client: LightstreamerClient, didChangeStatus status: LightstreamerClient.Status) {
        
    }
    
    func client(_ client: LightstreamerClient, didChangeProperty property: String) {
        
    }
    
    
}
