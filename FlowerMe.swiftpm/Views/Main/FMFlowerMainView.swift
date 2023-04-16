//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/04.
//

import SwiftUI

struct FMFlowerMainView: View {
    @ObservedObject var flowerVM: FlowerVM
    @ObservedObject var gestaltVM: GestaltVM
    @State private var isDetailCardViewDisplayed: Bool = false
    let gridSystem: [GridItem] = [
        .init(.flexible(), spacing: 25),
        .init(.flexible(), spacing: 25),
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: gridSystem) {
                ForEach(Constants.Gestalt.GESTALT_THEORIES, id: \.self) { text in
                    NavigationLink {
                        switch text {
                        case Constants.Gestalt.SIMILARITY:
                            SimilarityView(gestaltVM: gestaltVM)
                                .navigationTitle("Principle of Similarity")
                        case Constants.Gestalt.CONTINUITY:
                            ContinuationView(gestaltVM: gestaltVM)
                                .navigationTitle("Principle of Continuity")
                        case Constants.Gestalt.CLOSURE:
                            ClosureView(gestaltVM: gestaltVM)
                                .navigationTitle("Principle of Closure")
                        case Constants.Gestalt.PROXIMITY:
                            ProximityView(gestaltVM: gestaltVM)
                                .navigationTitle("Principle of Proximity")
                        case Constants.Gestalt.FIGUREGROUND:
                            FigureGroundView(gestaltVM: gestaltVM)
                                .navigationTitle("Principle of Figure And Ground")
                        case Constants.Gestalt.PRAGNANZ:
                            PragnanzView(gestaltVM: gestaltVM)
                                .navigationTitle("Principle of Prägnanz")
                        default:
                            EmptyView()
                        }
                    } label: {
                        FMCustomCardView(
                            style: .normal()
                        ) {
                            Text("**\(text)**")
                                .font(.title)
                                .padding()
                        }
                    }
                    .padding(.bottom, 25)
                }
            }
            .padding(.top, 32)
        }
    }
}
