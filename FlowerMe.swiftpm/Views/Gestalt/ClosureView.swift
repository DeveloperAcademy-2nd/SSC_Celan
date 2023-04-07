//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/05.
//

import SwiftUI
import SpriteKit

struct ClosureView: View {
    @ObservedObject var gestaltVM: GestaltVM
    @State private var topLeadingPetal: Double = 45.0
    @State private var topTrailingPetal: Double = 0.0
    @State private var bottomLeadingLeaf: Double = 72.0
    @State private var bottomTrailingLeaf: Double = -60.0
    @State private var isFirstDisplayed: Bool = false
    
    var body: some View {
        ZStack {
            HStack(spacing: -350) {
                // Left
                HalfFlowerView(
                    gestaltVM: gestaltVM,
                    topLeadingPetal: $topLeadingPetal,
                    bottomLeadingLeaf: $bottomLeadingLeaf
                )
                .overlay {
                    // Guide Line
                    VStack(spacing: 100) {
                        Petal()
                            .stroke(style: StrokeStyle(lineWidth: 4, dash: [10]))
                            .frame(width: 400, height: 400)
                            .rotationEffect(.degrees(270))
                        
                        Leaf()
                            .stroke(style: StrokeStyle(lineWidth: 4, dash: [10]))
                            .frame(width: 200, height: 200)
                            .rotationEffect(.degrees(180))
                            .rotation3DEffect(
                                .degrees(180),
                                axis: (x: -1, y: 1, z: 0)
                            )
                    }
                }
                
                // Right
                HalfFlowerReversedView(
                    gestaltVM: gestaltVM,
                    topTrailingPetal: $topTrailingPetal,
                    bottomTrailingLeaf: $bottomTrailingLeaf
                )
                .overlay {
                    // Guide Line
                    VStack(spacing: 100) {
                        Petal()
                            .stroke(style: StrokeStyle(lineWidth: 4, dash: [10]))
                            .frame(width: 400, height: 400)
                            .rotationEffect(.degrees(270))
                        
                        Leaf()
                            .stroke(style: StrokeStyle(lineWidth: 4, dash: [10]))
                            .frame(width: 200, height: 200)
                            .rotationEffect(.degrees(180))
                            .rotation3DEffect(
                                .degrees(180),
                                axis: (x: -1, y: 1, z: 0)
                            )
                    }
                    .rotation3DEffect(
                        .degrees(180),
                        axis: (x: 0, y: 1, z: 0)
                    )
                }
            }
            
            // 꽃대
            Group {
                Rectangle()
                    .frame(
                        width: UIScreen.main.bounds.width / 90,
                        height: UIScreen.main.bounds.height / 2.75
                    )
            }
            .frame(
                maxHeight: .infinity,
                alignment: .bottom
            )
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .onAppear {
            if !gestaltVM.isFirstDisplayedClosure {
                isFirstDisplayed.toggle()
            }
        }
        .show(isActivated: $isFirstDisplayed) {
            FMCustomCardView(style: .large()) {
                VStack {
                    Text(
                        """
                        Welcome to the Gestalt Principle of **Closure**!
                        
                        Here, You can tap each pieces of petals
                        and leaves to fit the space.
                        
                        After You finish your puzzle,
                        You can get a **Tulip** badge
                        and explanation of the principle!
                        
                        Gook Luck!
                        """
                    )
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 64)
                    
                    Button {
                        withAnimation {
                            gestaltVM.isFirstDisplayedClosure = true
                            isFirstDisplayed.toggle()
                        }
                    } label: {
                        Text("OK!")
                            .bold()
                            .padding(24)
                            .padding(.horizontal, 24)
                    }
                    .buttonStyle(.borderedProminent)

                }
                .padding(24)
                .frame(maxHeight: .infinity)
            }
        }
        .show(isActivated: $gestaltVM.closurePuzzleCleared) {
            FMCustomCardView(style: .large()) {
                VStack {
                    Text(
                        """
                        Conguratulations!
                        You have cleared The Gestalt Principle of **Closure**!
                        
                        The Gestalt Principle of Closure states that
                        if someone looks at a complex arrangement of visual elements,
                        they tend to look for a single and recognizable pattern.
                        
                        Did you recognize?
                        with your puzzle pieces, It draws a Tulip!
                        
                        And now you have a **Tulip** badge!
                        """
                    )
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 64)
                    
                    Button {
                        withAnimation {
                            gestaltVM.closurePuzzleCleared.toggle()
                        }
                    } label: {
                        Text("Hurray!")
                            .bold()
                            .padding(24)
                            .padding(.horizontal, 24)
                    }
                    .buttonStyle(.borderedProminent)

                }
                .padding(24)
                .frame(maxHeight: .infinity)
            }
        }
    }
}
