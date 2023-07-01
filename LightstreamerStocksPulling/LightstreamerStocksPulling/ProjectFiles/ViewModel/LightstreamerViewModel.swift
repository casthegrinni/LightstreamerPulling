//
//  LightstreamerViewModel.swift
//  LightstreamerStocksPulling
//
//  Created by Brunno Castigrini on 30/06/23.
//

import SwiftUI
import LightstreamerClient

class LightstreamerViewModel: ObservableObject {
    private var subscription: Subscription?
    @Published var stocks: [Stock] = []
    
    func connect() {
        let items = ["item1", "item2", "item3", "item4", "item5", "item6", "item7", "item8", "item9", "item10"]
        self.subscription = Subscription(subscriptionMode: .MERGE, items: items, fields:  ["last_price", "stock_name"])
        if let subscription = self.subscription {
            subscription.dataAdapter = DATA_ADAPTER
            subscription.requestedSnapshot = .yes
            subscription.addDelegate(self)
            Connector.shared().subscribe(subscription)
            Connector.shared().connect()
        }
    }
    
    func disconnect() {
        Connector.shared().disconnect()
    }
}

extension LightstreamerViewModel: SubscriptionDelegate {
    @MainActor
    func subscription(_ subscription: Subscription, didUpdateItem itemUpdate: ItemUpdate) {
        Task {
            let stockName: String = itemUpdate.value(withFieldName: "stock_name") ?? ""
            let lastPrice: Double = Double(itemUpdate.value(withFieldName: "last_price") ?? "0")!
            
            let stock: Stock = Stock(name: stockName, lastPrice: lastPrice)
            print("Stock name: \(stockName)\nLastPrice: \(lastPrice)")
            
            let itemPosition = itemUpdate.itemPos
            let isIndexValid: Bool = self.stocks.indices.contains(itemPosition)
            
            if isIndexValid {
                stocks.remove(at: itemPosition)
                stocks.insert(stock, at: itemPosition)
            } else {
                stocks.append(stock)
            }
        }
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
