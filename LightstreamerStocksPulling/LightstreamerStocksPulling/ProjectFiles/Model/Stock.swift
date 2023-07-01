//
//  Stock.swift
//  LightstreamerStocksPulling
//
//  Created by Brunno Castigrini on 30/06/23.
//

import Foundation
struct Stock: Identifiable {
    let id = UUID()
    let name: String
    let lastPrice: Double
}
