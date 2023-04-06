//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/04.
//

import SwiftUI

struct FMFlowerMainView: View {
    @ObservedObject var flowerVM: FlowerVM
    @State private var isDetailCardViewDisplayed: Bool = false
    let gridSystem: [GridItem] = [
        .init(.flexible(), spacing: 50),
        .init(.flexible(), spacing: 50),
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: gridSystem) {
                ForEach(Constants.Gestalt.GESTALT_THEORIES, id: \.self) { text in
                    NavigationLink {
                        switch text {
                        case Constants.Gestalt.SIMILARITY:
                            SimilarityView()
                        case Constants.Gestalt.CONTINUATION:
                            ContinuationView()
                        case Constants.Gestalt.CLOSURE:
                            ClosureView()
                        case Constants.Gestalt.PROXIMITY:
                            ProximityView()
                        case Constants.Gestalt.FIGUREGROUND:
                            FigureGroundView()
                        case Constants.Gestalt.PRAGNANZ:
                            PragnanzView()
                        default:
                            EmptyView()
                        }
                    } label: {
                        FMCustomCardView(
                            style: .mini(
                                horizontalPadding: 225,
                                verticalPadding: 225
                            )
                        ) {
                            Text(text)
                                .font(.title)
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
            .padding(.top, 32)
        }
        .padding(.horizontal, 32)
        // TODO: - show Method에서 라벨링 할 뷰 분리 필요, 아마 꽃의 정보가 될 듯
//        .show(isActivated: $isDetailCardViewDisplayed) {
//            FMCustomCardView(style: .large()) {
//                if let currentFlower = flowerVM.currentFlower {
//                    VStack {
//                        // MARK: - Flower Name
//                        VStack(alignment: .leading) {
//                            Text(currentFlower.name)
//                                .font(.title)
//
//                            Divider()
//                        }
//                        .frame(
//                            maxWidth: .infinity,
//                            alignment: .topLeading
//                        )
//                        .background(content: {
//                            Color.red
//                        })
//
//                        VStack(alignment: .leading) {
//                            // MARK: - Image Assets will be here
//                            Image(systemName: "tree")
//                        }
//                        .frame(
//                            maxWidth: .infinity,
//                            alignment: .topLeading
//                        )
//                        .background(content: {
//                            Color.blue
//                        })
//
//                        // MARK: - Full Bloom Section
//                        VStack(alignment: .leading) {
//                            Text("Full Bloom in: ")
//                                .font(.headline)
//
//                            HStack {
//
//                                ForEach(0..<currentFlower.tintColors.count, id: \.self) { index in
//                                    Circle()
//                                        .fill(currentFlower.tintColors[index])
//                                        .frame(width: 85, height: 85)
//                                        .overlay {
//                                            Text(currentFlower.bloomingSeason[index])
//                                                .bold()
//                                        }
//                                }
//                            }
//                        }
//                        .frame(
//                            maxWidth: .infinity,
//                            maxHeight: .infinity,
//                            alignment: .bottomLeading
//                        )
//                        .background(content: {
//                            Color.yellow
//                        })
//                    }
//
//                    .padding(.vertical, 24)
//                }
//            }
//        }
    }
}
