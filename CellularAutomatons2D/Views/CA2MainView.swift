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
                Picker("", selection: $rowSize) {
                    ForEach(1...15, id: \.self) {
                        Text("\($0)")
                    }
                }
                .labelsHidden()
                .onChange(of: rowSize) { _ in
                    vm.setupSize(row: rowSize, col: colSize)
                }
                Text("Column")
                Picker("", selection: $colSize) {
                    ForEach(1...20, id: \.self) {
                        Text("\($0)")
                    }
                }
                .labelsHidden()
                .onChange(of: colSize) { _ in
                    vm.setupSize(row: rowSize, col: colSize)
                }
                HStack {
                    Button("Start") {
                        if !isPaused {
                            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                                vm.evolve()
                            }
                            isPaused = true
                        }
                    }
                    Button("Stop") {
                        isPaused = false
                        timer?.invalidate()
                    }
                    Button("Reset") {
                        timer = nil
                        vm.reset()
                    }
                }.padding(.top)
            }
            .padding()
            .frame(minWidth: 300, maxWidth: 300, maxHeight: .infinity)
            VStack {
                ForEach(vm.cellularPlane.indices, id: \.self) { i in
                    HStack {
                        ForEach(vm.cellularPlane[i].indices, id: \.self) { j in
                            Rectangle()
                                .frame(width: 50, height: 50)
                                .foregroundColor((vm.cellularPlane[i][j].state == 1) ? .black : .white)
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
