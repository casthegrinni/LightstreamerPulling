//
//  Constants.swift
//  LightstreamerStocksPulling
//
//  Created by Brunno Castigrini on 30/06/23.
//

import UIKit

let PUSH_SERVER_URL = "https://push.lightstreamer.com"
let ADAPTER_SET = "DEMO"
let DATA_ADAPTER = "QUOTE_ADAPTER"

let LIST_FIELDS = ["last_price", "stock_name"]

let NOTIFICATION_CONN_STATUS = NSNotification.Name("LSConnectionStatusChanged")
let NOTIFICATION_CONN_ENDED = NSNotification.Name("LSConnectionEnded")

let IS_CONNECTED = "isConnected"
