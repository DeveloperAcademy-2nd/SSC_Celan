//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/04.
//

import SwiftUI

struct FMFlowerMainView: View {
    @ObservedObject var gestaltVM: GestaltVM
    @State private var selection: Int = 0
    
    var body: some View {
        VStack {
            Picker("", selection: $selection) {
                ForEach(
                    0..<Constants.Gestalt.GESTALT_THEORIES.count,
                    id: \.self) { index in
                        Text(Constants.Gestalt.GESTALT_THEORIES[index])
                            .tag(index)
                    }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 24)
            .frame(alignment: .top)
            .zIndex(99)
            
            switch Constants.Gestalt.GESTALT_THEORIES[selection] {
            case Constants.Gestalt.SIMILARITY:
                SimilarityView(gestaltVM: gestaltVM)
                    .navigationTitle(Constants.Gestalt.SIMILARITY)
                    .frame(
                        alignment: .center
                    )
                
                Spacer()
            case Constants.Gestalt.PROXIMITY:
                ProximityView(gestaltVM: gestaltVM)
                    .navigationTitle(Constants.Gestalt.PROXIMITY)
                    .frame(
                        maxHeight: .infinity
                    )
            case Constants.Gestalt.CONTINUITY:
                ContinuationView(gestaltVM: gestaltVM)
                    .navigationTitle(Constants.Gestalt.CONTINUITY)
                    .frame(
                        maxHeight: .infinity,
                        alignment: .center
                    )
            case Constants.Gestalt.CLOSURE:
                ClosureView(gestaltVM: gestaltVM)
                    .navigationTitle(Constants.Gestalt.CLOSURE)
                    .frame(maxWidth: .infinity)
            case Constants.Gestalt.PRAGNANZ:
                PragnanzView(gestaltVM: gestaltVM)
                    .navigationTitle(Constants.Gestalt.PRAGNANZ)
                    .frame(
                        maxHeight: .infinity,
                        alignment: .center
                    )
            case Constants.Gestalt.FIGUREGROUND:
                Spacer()
                
                FigureGroundView(gestaltVM: gestaltVM)
                    .navigationTitle(Constants.Gestalt.FIGUREGROUND)
                    .frame(
                        maxHeight: .infinity,
                        alignment: .center
                    )
            default:
                Text("UNKNOWN")
            }
            
        }
    }
}
