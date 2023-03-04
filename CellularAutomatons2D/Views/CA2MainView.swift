//
//  CA2MainView.swift
//  CellularAutomatons2D
//
//  Created by Steven Wijaya on 04.03.2023.
//

import SwiftUI

struct CA2MainView: View {
    
    @StateObject private var vm: CA2ViewModel = CA2ViewModel()
    @State private var rowSize: Int = 15
    @State private var colSize: Int = 15
    
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
    
    @State private var timer: Timer? = nil
    @State private var isPaused: Bool = false
    
    var body: some View {
        HSplitView {
            VStack(alignment: .leading) {
                Text("Row")
                CA2Picker(data: $rowSize, upperLimit: 15)
                .onChange(of: rowSize) { _ in
                    vm.setupSize(row: rowSize, col: colSize)
                }
                Text("Column")
                CA2Picker(data: $colSize, upperLimit: 20)
                .onChange(of: colSize) { _ in
                    vm.setupSize(row: rowSize, col: colSize)
                }
                HStack {
                    startButton
                    stopButton
                    resetButton
                }.padding(.top)
            }
            .padding()
            .frame(minWidth: 300, maxWidth: 300, maxHeight: .infinity)
            VStack {
                ForEach(vm.cellularPlane.indices, id: \.self) { i in
                    HStack {
                        ForEach(vm.cellularPlane[i].indices, id: \.self) { j in
                            CA2CellView(state: vm.cellularPlane[i][j].state)
                                .onTapGesture {
                                    vm.cellularPlane[i][j].toggle()
                                }
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct CA2MainView_Previews: PreviewProvider {
    static var previews: some View {
        CA2MainView()
    }
}

extension CA2MainView {
    private var startButton: some View {
        Button("Start") {
            if !isPaused {
                timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                    vm.evolve()
                }
                isPaused = true
            }
        }
    }
    
    private var stopButton: some View {
        Button("Stop") {
            isPaused = false
            timer?.invalidate()
        }
    }
    
    private var resetButton: some View {
        Button("Reset") {
            timer = nil
            vm.reset()
        }
    }
}
