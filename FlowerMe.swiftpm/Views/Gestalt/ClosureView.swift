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
            if gestaltVM.isClosurePuzzleDone || gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE) {
                Button {
                    withAnimation {
                        if !gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE) {
                            gestaltVM.closurePuzzleCleared = true
                            gestaltVM.clearedPrinciples.append(Constants.Gestalt.CLOSURE)
                        }
                    }
                } label: {
                    Text("🌷")
                        .font(.system(size: UIScreen.main.bounds.width / 10))
                        .frame(
                            maxWidth: UIScreen.main.bounds.width / 8,
                            maxHeight: UIScreen.main.bounds.height / 8
                        )
                }
                .overlay {
                    Circle()
                        .stroke(
                            style: StrokeStyle(
                                lineWidth: 3, dash: [5]
                            )
                        )
                }
            }
            
            HStack(spacing: -350) {
                // Left
                HalfFlowerView(
                    gestaltVM: gestaltVM,
                    topLeadingPetal: $topLeadingPetal,
                    bottomLeadingLeaf: $bottomLeadingLeaf
                )
                .overlay {
                    // Guide Line
                    if gestaltVM.isClosurePuzzleDone || gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE) {
                        
                    } else {
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
                }
                
                // Right
                HalfFlowerReversedView(
                    gestaltVM: gestaltVM,
                    topTrailingPetal: $topTrailingPetal,
                    bottomTrailingLeaf: $bottomTrailingLeaf
                )
                .overlay {
                    if gestaltVM.isClosurePuzzleDone || gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE) {
                        
                    } else {
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
            }
            
            // 꽃대
            Group {
                Rectangle()
                    .fill(
                        gestaltVM.isClosurePuzzleDone || gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE)
                        ? LinearGradient(
                            gradient:
                                Gradient(
                                    colors: [
                                        .green,
                                        .green,
                                        .white
                                    ]
                                ),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        : LinearGradient(
                            gradient:
                                Gradient(
                                    colors: [
                                        .black
                                    ]
                                ),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(
                        width: UIScreen.main.bounds.width / 90,
                        height: UIScreen.main.bounds.height / 2.75
                    )
            }
            .frame(
                maxHeight: .infinity,
                alignment: .bottom
            )
            
            if gestaltVM.closurePuzzleCleared {
                MiniFlower(tintColor: .red, budColor: .white, radian: 2)
                    .font(.title2)
                    .modifier(ParticlesModifier())
                    .frame(
                        maxHeight: .infinity
                    )
                
                FMFlower(tintColor: .yellow, budColor: .white)
                    .modifier(ParticlesModifier(numberOfParticles: 7))
            }
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
        .onDisappear {
            // 클리어하지 않고 나갔을 땐 배열을 초기화해주자~
            if gestaltVM.closurePuzzle.count != 4 {
                gestaltVM.closurePuzzle.removeAll()
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

                }
                .padding(24)
                .frame(maxHeight: .infinity)
            }
            .overlay(alignment: .bottom) {
                Button {
                    withAnimation {
                        gestaltVM.isFirstDisplayedClosure = true
                        isFirstDisplayed.toggle()
                    }
                } label: {
                    Text("OK!")
                        .bold()
                        .foregroundColor(.primary)
                        .padding(24)
                        .padding(.horizontal, 24)
                }
                .buttonStyle(.borderedProminent)
                .padding()
                .padding()
            }
        }
        .show(isActivated: $gestaltVM.closurePuzzleCleared) {
            FMCustomCardView(style: .large()) {
                VStack {
                    Text(
                        """
                        💐 Conguratulations!
                        
                        You have cleared The Gestalt Principle of **Closure**!
                        
                        The Gestalt Principle of Closure states that
                        if someone looks at a complex arrangement of visual elements,
                        they tend to look for a single and recognizable pattern.
                        
                        Did you recognize?
                        With your puzzle pieces, you drawn a **Tulip**!
                        
                        And now you have a **Tulip** badge!
                        """
                    )
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 64)

                }
                .padding(24)
                .frame(maxHeight: .infinity)
            }
            .overlay(alignment: .bottom) {
                Button {
                    withAnimation {
                        gestaltVM.closurePuzzleCleared.toggle()
                    }
                } label: {
                    Text("Hurray!")
                        .bold()
                        .foregroundColor(.primary)
                        .padding(24)
                        .padding(.horizontal, 24)
                }
                .buttonStyle(.borderedProminent)
                .padding()
                .padding()
            }
        }
    }
}

struct ClosurePreview: PreviewProvider {
    static var previews: some View {
        ClosureView(gestaltVM: GestaltVM())
    }
}
