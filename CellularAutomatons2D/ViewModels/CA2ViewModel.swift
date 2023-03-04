//
//  CA2ViewModel.swift
//  CellularAutomatons2D
//
//  Created by Steven Wijaya on 04.03.2023.
//

import Foundation

final class CA2ViewModel: ObservableObject {
    @Published var cellularPlane: [[Cell]] = [[Cell]]()
    @Published var generation: Int = 0
    
    private var rows: Int = 15
    private var cols: Int = 15
    
    init() {
        for _ in 0..<rows {
            var row: [Cell] = [Cell]()
            for _ in 0..<cols {
                row.append(Cell())
            }
            cellularPlane.append(row)
        }
    }
    
    func setupSize(row: Int, col: Int) {
        self.rows = row
        self.cols = col
        generateNewCellularPlane()
    }
    
    func reset() {
        generateNewCellularPlane()
    }
    
    private func generateNewCellularPlane() {
        cellularPlane.removeAll()
        for _ in 0..<rows {
            var row: [Cell] = [Cell]()
            for _ in 0..<cols {
                row.append(Cell())
            }
            cellularPlane.append(row)
        }
    }
    
    func evolve() {
        var newGenerationPlane: [[Cell]] = [[Cell]]()
        
        for i in 0..<rows {
            var newGenerationRow: [Cell] = [Cell]()
            for j in 0..<cols {
                var currentCell: Cell = cellularPlane[i][j]
                var neighbours: [Cell] = [Cell]()
                
                neighbours += generateAllNeighbours(i: i, j: j)
                print("\(i), \(j)")
                print(neighbours)
                
                useConwayRule(currentCell: &currentCell, neighbours: neighbours)
                newGenerationRow.append(currentCell)
            }
            newGenerationPlane.append(newGenerationRow)
        }
        // Assign cellularPlane with the new generation of cells
        cellularPlane = newGenerationPlane
        generation += 1
    }
    
    private func generateAllNeighbours(i: Int, j: Int) -> [Cell] {
        var top: Cell = Cell()
        var diagonalTopRight: Cell = Cell()
        var right: Cell = Cell()
        var diagonalBottomRight: Cell = Cell()
        var bottom: Cell = Cell()
        var diagonalBottomLeft: Cell = Cell()
        var left: Cell = Cell()
        var diagonalTopLeft: Cell = Cell()
        
        // Check all edge cases because here we include all of the edge cases from the matrix.
        if i == 0 && j == 0 {
            // Top left edge cases
            top = cellularPlane[rows - 1][j]
            diagonalTopRight = cellularPlane[rows - 1][j + 1]
            right = cellularPlane[i][j + 1]
            diagonalBottomRight = cellularPlane[i + 1][j + 1]
            bottom = cellularPlane[i + 1][j]
            diagonalBottomLeft = cellularPlane[i + 1][cols - 1]
            left = cellularPlane[i][cols - 1]
            diagonalTopLeft = cellularPlane[rows - 1][cols - 1]
        } else if i == 0 && (j < cols - 1) {
            // Top edge cases with cols from index 1 to last index - 1
            top = cellularPlane[rows - 1][j]
            diagonalTopRight = cellularPlane[rows - 1][j + 1]
            right = cellularPlane[i][j + 1]
            diagonalBottomRight = cellularPlane[i + 1][j + 1]
            bottom = cellularPlane[i + 1][j]
            diagonalBottomLeft = cellularPlane[i + 1][j - 1]
            left = cellularPlane[i][j - 1]
            diagonalTopLeft = cellularPlane[rows - 1][j - 1]
        } else if j == 0 && (i < rows - 1) {
            // Left edge cases with rows from index 1 to last index - 1
            top = cellularPlane[i - 1][j]
            diagonalTopRight = cellularPlane[i - 1][j + 1]
            right = cellularPlane[i][j + 1]
            diagonalBottomRight = cellularPlane[i + 1][j + 1]
            bottom = cellularPlane[i + 1][j]
            diagonalBottomLeft = cellularPlane[i + 1][cols - 1]
            left = cellularPlane[i][cols - 1]
            diagonalTopLeft = cellularPlane[i - 1][cols - 1]
        } else if (i == rows - 1) && j == 0  {
            // Bottom left edge cases
            top = cellularPlane[i - 1][j]
            diagonalTopRight = cellularPlane[i - 1][j + 1]
            right = cellularPlane[i][j + 1]
            diagonalBottomRight = cellularPlane[0][j + 1]
            bottom = cellularPlane[0][j]
            diagonalBottomLeft = cellularPlane[0][cols - 1]
            left = cellularPlane[i][cols - 1]
            diagonalTopLeft = cellularPlane[i - 1][cols - 1]
        } else if (i == rows - 1) && (j < cols - 1) {
            // Bottom edge cases with cols from index 1 to last index - 1
            top = cellularPlane[i - 1][j]
            diagonalTopRight = cellularPlane[i - 1][j + 1]
            right = cellularPlane[i][j + 1]
            diagonalBottomRight = cellularPlane[0][j + 1]
            bottom = cellularPlane[0][j]
            diagonalBottomLeft = cellularPlane[0][j - 1]
            left = cellularPlane[i][j - 1]
            diagonalTopLeft = cellularPlane[i - 1][j - 1]
        } else if i == 0 && (j == cols - 1) {
            // Top right edge cases
            top = cellularPlane[rows - 1][j]
            diagonalTopRight = cellularPlane[rows - 1][0]
            right = cellularPlane[i][0]
            diagonalBottomRight = cellularPlane[i + 1][0]
            bottom = cellularPlane[i + 1][j]
            diagonalBottomLeft = cellularPlane[i + 1][j - 1]
            left = cellularPlane[i][j - 1]
            diagonalTopLeft = cellularPlane[rows - 1][j - 1]
        } else if (j == cols - 1) && (i < rows - 1) {
            // Right edge cases with rows from index 1 to last index - 1
            top = cellularPlane[i - 1][j]
            diagonalTopRight = cellularPlane[i - 1][0]
            right = cellularPlane[i][0]
            diagonalBottomRight = cellularPlane[i + 1][0]
            bottom = cellularPlane[i + 1][j]
            diagonalBottomLeft = cellularPlane[i + 1][j - 1]
            left = cellularPlane[i][j - 1]
            diagonalTopLeft = cellularPlane[i - 1][j - 1]
        } else if (i == rows - 1) && (j == cols - 1) {
            // Bottom right edge cases
            top = cellularPlane[i - 1][j]
            diagonalTopRight = cellularPlane[i - 1][0]
            right = cellularPlane[i][0]
            diagonalBottomRight = cellularPlane[0][0]
            bottom = cellularPlane[0][j]
            diagonalBottomLeft = cellularPlane[0][j - 1]
            left = cellularPlane[i][j - 1]
            diagonalTopLeft = cellularPlane[i - 1][j - 1]
        } else {
            // Common cases i and j start from 1 and end to finalIndex - 1
            top = cellularPlane[i - 1][j]
            diagonalTopRight = cellularPlane[i - 1][j + 1]
            right = cellularPlane[i][j + 1]
            diagonalBottomRight = cellularPlane[i + 1][j + 1]
            bottom = cellularPlane[i + 1][j]
            diagonalBottomLeft = cellularPlane[i + 1][j - 1]
            left = cellularPlane[i][j - 1]
            diagonalTopLeft = cellularPlane[i - 1][j - 1]
        }
        
        return [top, diagonalTopRight, right, diagonalBottomRight, bottom, diagonalBottomLeft, left, diagonalTopLeft]
    }
}
