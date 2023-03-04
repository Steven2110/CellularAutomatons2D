//
//  Cell.swift
//  CellularAutomatons2D
//
//  Created by Steven Wijaya on 04.03.2023.
//

import Foundation

struct Cell: Identifiable {
    let id: UUID = UUID()
    var state: Int = 0
    
    mutating func toggle() {
        state == 1 ? (state = 0) : (state = 1)
    }
}
