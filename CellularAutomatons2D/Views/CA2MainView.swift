//
//  CA2MainView.swift
//  CellularAutomatons2D
//
//  Created by Steven Wijaya on 04.03.2023.
//

import SwiftUI

struct CA2MainView: View {
    
    @State private var cellularPlane: [[Cell]] = [
        [Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell()],
        [Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell()],
        [Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell()],
        [Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell()],
        [Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell()],
        [Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell()],
        [Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell()],
        [Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell()],
        [Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell()],
        [Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell()]
    ]
    
    var body: some View {
        VStack {
            HStack {
                Button("Start") {
                    
                }
                Button("Stop") {
                    
                }
                Button("Reset") {
                    
                }
            }.padding()
            VStack {
                ForEach(cellularPlane.indices, id: \.self) { i in
                    HStack {
                        ForEach(cellularPlane[i].indices, id: \.self) { j in
                            Rectangle()
                                .frame(width: 50, height: 50)
                                .foregroundColor((cellularPlane[i][j].state == 1) ? .black : .white)
                                .onTapGesture {
                                    cellularPlane[i][j].toggle()
                                }
                        }
                    }
                }
            }.padding(.bottom, 20)
        }
    }
}

struct CA2MainView_Previews: PreviewProvider {
    static var previews: some View {
        CA2MainView()
    }
}
