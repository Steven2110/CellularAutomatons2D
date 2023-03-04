//
//  CA2Picker.swift
//  CellularAutomatons2D
//
//  Created by Steven Wijaya on 04.03.2023.
//

import SwiftUI

struct CA2Picker: View {
    
    @Binding var data: Int
    var lowerLimit: Int = 1
    var upperLimit: Int
    
    var body: some View {
        Picker("", selection: $data) {
            ForEach(lowerLimit...upperLimit, id: \.self) {
                Text("\($0)")
            }
        }
        .labelsHidden()
    }
}

struct CA2Picker_Previews: PreviewProvider {
    static var previews: some View {
        CA2Picker(data: .constant(5), upperLimit: 15)
    }
}
