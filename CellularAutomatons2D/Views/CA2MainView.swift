//
//  CA2MainView.swift
//  CellularAutomatons2D
//
//  Created by Steven Wijaya on 04.03.2023.
//

import SwiftUI

struct CA2MainView: View {
    
    @State private var cellularPlane: [[Int]] = [
        [0, 0, 0, 0, 1, 0, 1, 1, 0, 0],
        [0, 0, 0, 1, 0, 0, 1, 0, 1, 0],
        [0, 0, 0, 0, 1, 0, 0, 1, 1, 0],
        [0, 1, 0, 1, 1, 0, 1, 0, 0, 0],
        [0, 1, 0, 1, 1, 0, 1, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0, 0, 1, 0],
        [0, 0, 1, 0, 0, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
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
                                .foregroundColor((cellularPlane[i][j] == 1) ? .black : .white)
                                .onTapGesture {
                                    if (cellularPlane[i][j] == 0) {
                                        cellularPlane[i][j] = 1
                                    } else {
                                        cellularPlane[i][j] = 0
                                    }
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
