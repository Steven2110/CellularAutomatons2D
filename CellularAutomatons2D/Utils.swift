//
//  Utils.swift
//  CellularAutomatons2D
//
//  Created by Steven Wijaya on 04.03.2023.
//

import Foundation


func useConwayRule(currentCell: inout Cell, neighbours: [Cell]) {
    let numberOfAliveNeighbour: Int = getNumberOfAliveNeighbour(fromNeighborhood: neighbours)
    
    // The rules:
    // 1. Any live cell with <2 alive neighbours dies, as if by underpopulation;
    // 2. Any live cell with 2-3 alive neighbours lives on to the next generation;
    // 3. Any live cell with >3 alive neighbours dies, as if by overpopulation;
    // 4. Any dead cell with 3 alive neighbours becomes a live cell, as if by reproduction.
    if currentCell.state == 1 {
        if numberOfAliveNeighbour < 2 {
            currentCell.toggle()
        } else if numberOfAliveNeighbour > 3 {
            currentCell.toggle()
        }
    } else if currentCell.state == 0 {
        if numberOfAliveNeighbour == 3 {
            currentCell.toggle()
        }
    }
}

func getNumberOfAliveNeighbour(fromNeighborhood neighbours: [Cell]) -> Int {
    var alive: Int = 0
    
    for neighbour in neighbours {
        if neighbour.state == 1 {
            alive += 1
        }
    }
    
    return alive
}
