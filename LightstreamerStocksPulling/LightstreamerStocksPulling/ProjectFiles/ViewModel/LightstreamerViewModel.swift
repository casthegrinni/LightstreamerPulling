//
//  LightstreamerViewModel.swift
//  LightstreamerStocksPulling
//
//  Created by Brunno Castigrini on 30/06/23.
//

import Foundation
import SwiftUI

class LightstreamerViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    
    
    func connect() {
        
    }
    
    func disconnect() {
        
    }
}
