//
//  CA2CellView.swift
//  CellularAutomatons2D
//
//  Created by Steven Wijaya on 04.03.2023.
//

import SwiftUI

struct CA2CellView: View {
    var state: Int
    var body: some View {
        Rectangle()
            .frame(width: 50, height: 50)
            .foregroundColor((state == 1) ? .black : .white)
    }
}

struct CA2CellView_Previews: PreviewProvider {
    static var previews: some View {
        CA2CellView(state: 1)
    }
}
