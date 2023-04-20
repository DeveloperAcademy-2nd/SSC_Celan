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
        ScrollView(showsIndicators: false) {
            // MARK: - Head
            Text("The Gestalt Principle of \n**\(Constants.Gestalt.CLOSURE)**")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            ZStack {
                if gestaltVM.isClosurePuzzleDone
                    || gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE) {
                    Button {
                        withAnimation {
                            if !gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE) {
                                gestaltVM.closurePuzzleCleared = true
                            }
                        }
                    } label: {
                        Text("🌷")
                            .font(.system(size: Constants.ReactiveCGFloat.REACTIVE_WIDTH / 10))
                            .overlay {
                                Circle()
                                    .stroke(
                                        style: StrokeStyle(
                                            lineWidth: 3, dash: [5]
                                        )
                                    )
                            }
                    }
                    .frame(
                        maxWidth: Constants.ReactiveCGFloat.REACTIVE_WIDTH / 8,
                        maxHeight: Constants.ReactiveCGFloat.REACTIVE_HEIGHT / 3,
                        alignment: .top
                    )
                    .foregroundColor(.primary)
                }
                
                HStack(spacing: -(Constants.ClosureFlowerCGFloat.CLOSURE_WIDTH - 25)) {
                    // Left
                    HalfFlowerView(
                        gestaltVM: gestaltVM,
                        topLeadingPetal: $topLeadingPetal,
                        bottomLeadingLeaf: $bottomLeadingLeaf
                    )
                    .overlay {
                        // Guide Line
                        if gestaltVM.isClosurePuzzleDone
                            || gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE) {
                            
                        } else {
                            VStack(spacing: Constants.ClosureFlowerCGFloat.CLOSURE_WIDTH / 6) {
                                Petal()
                                    .stroke(style: StrokeStyle(lineWidth: 4, dash: [10]))
                                    .frame(
                                        width: Constants.ClosureFlowerCGFloat.CLOSURE_WIDTH,
                                        height: Constants.ClosureFlowerCGFloat.CLOSURE_HEIGHT
                                    )
                                    .rotationEffect(.degrees(270))
                                
                                Leaf()
                                    .stroke(style: StrokeStyle(lineWidth: 4, dash: [10]))
                                    .frame(
                                        width: Constants.ClosureFlowerCGFloat.CLOSURE_WIDTH / 2,
                                        height: Constants.ClosureFlowerCGFloat.CLOSURE_HEIGHT / 2
                                    )
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
                        if gestaltVM.isClosurePuzzleDone
                            || gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE) {
                            
                        } else {
                            VStack(spacing: Constants.ClosureFlowerCGFloat.CLOSURE_WIDTH / 6) {
                                Petal()
                                    .stroke(style: StrokeStyle(lineWidth: 4, dash: [10]))
                                    .frame(
                                        width: Constants.ClosureFlowerCGFloat.CLOSURE_WIDTH,
                                        height: Constants.ClosureFlowerCGFloat.CLOSURE_HEIGHT
                                    )
                                    .rotationEffect(.degrees(270))
                                
                                Leaf()
                                    .stroke(style: StrokeStyle(lineWidth: 4, dash: [10]))
                                    .frame(
                                        width: Constants.ClosureFlowerCGFloat.CLOSURE_WIDTH / 2,
                                        height: Constants.ClosureFlowerCGFloat.CLOSURE_HEIGHT / 2
                                    )
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
                flowerStalkBuild()
                    .frame(
                        maxHeight: .infinity,
                        alignment: .bottom
                    )
                
                if gestaltVM.closurePuzzleCleared {
                    Text("🌷")
                        .font(.largeTitle)
                        .modifier(ParticlesModifier())
                }
            }
            .frame(maxWidth: .infinity)
            .scaleEffect(UIScreen.main.bounds.width > UIScreen.main.bounds.height ? 0.8 : 1.0)
            .padding()
            
            // MARK: - Description
            descriptionBuild()
                .padding(32)
                .background {
                    RoundedRectangle(
                        cornerRadius: 25.0,
                        style: .continuous
                    )
                    .stroke(style: .init(lineWidth: 4))
                    .padding(.horizontal, 32)
                }
            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, getPadding())
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
            FMCustomCardView(style: .normal()) {
                VStack {
                    Text(
                        """
                        Welcome to the Gestalt Principle of **Closure**!
                        
                        Here, You can tap each pieces of petals
                        and leaves to fit the space.
                        
                        After You finish your puzzle,
                        You can get a basic understanding about the principle of **Closure**!
                        
                        Gook Luck!
                        """
                    )
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 64)
                    .padding()
                    
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
            FMCustomCardView(style: .normal()) {
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
                        """
                    )
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 64)
                    .padding()
                    
                }
                .padding(24)
                .frame(maxHeight: .infinity)
            }
            .onDisappear {
                withAnimation {
                    gestaltVM.clearedPrinciples.append(Constants.Gestalt.CLOSURE)
                }
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
        .overlay(alignment: .bottomLeading) {
                DismissButton()
        }
    }
    
    // 꽃대
    private func flowerStalkBuild() -> some View {
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
                    width: Constants.ReactiveCGFloat.REACTIVE_WIDTH / 90,
                    height: Constants.ReactiveCGFloat.REACTIVE_HEIGHT / 7
                )
        }
    }
    
    @ViewBuilder
    private func descriptionBuild() -> some View {
        if gestaltVM.closurePuzzle.count == 2 {
            Text("As You fit the pieces, \nIt has gap and it draws a Tulip!")
                .font(.title)
                .foregroundColor(.accentColor)
                .multilineTextAlignment(.center)
                .padding()
            
        } else if gestaltVM.closurePuzzle.count == 3 {
            Text("Because your brain fills those gaps!")
                .bold()
                .font(.title)
                .foregroundColor(.accentColor)
                .multilineTextAlignment(.center)
                .padding()
            
        } else if gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE) {
           Text("You have cleared this principle!")
               .bold()
               .font(.title)
               .foregroundColor(.accentColor)
               .multilineTextAlignment(.center)
               .padding()
            
       } else if !gestaltVM.isClosurePuzzleDone {
            Text("**Tap the pieces** to make them fit into the space!")
                .font(.title)
                .foregroundColor(.accentColor)
                .padding()
           
        } else if gestaltVM.isClosurePuzzleDone {
            Text("And You did it! \nYou finally make a tulip with a gaps!")
                .font(.title)
                .foregroundColor(.accentColor)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
    
    private func getPadding() -> CGFloat {
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            return UIScreen.main.bounds.width / 5
        } else {
            return 0
        }
    }
    
}
