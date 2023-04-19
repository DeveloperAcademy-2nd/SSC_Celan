//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/05.
//

import SwiftUI
import Combine

struct SimilarityView: View {
    @ObservedObject var gestaltVM: GestaltVM
    @State private var isFirstDisplayed: Bool = false
    @State private var isPressing: Bool = false
    @State private var completeRatio: CGFloat = 0.0
    
    var timer = Timer.publish(every: 0.2, on: .main, in: .common)
        .autoconnect()
        .eraseToAnyPublisher()
    
    let gridItem: [GridItem] = Array(
        repeating: .init(
            .flexible(maximum: Constants.ReactiveCGFloat.REACTIVE_HEIGHT),
            spacing: 15
        ),
        count: 8
    )
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                descriptionBuild()
                    .frame(
                        minHeight: 100,
                        alignment: .top
                    )
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: gridItem, spacing: 30) {
                        // 0~63 : 64개
                        ForEach(0..<64, id: \.self) { index in
                            ZStack {
                                // 0-32 : 33
                                if index < 32 {
                                    if gestaltVM.sectionA.contains(index) {
                                        FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacityA)
                                    } else if gestaltVM.sectionB.contains(index) {
                                        FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacityB)
                                    } else if gestaltVM.sectionC.contains(index) {
                                        FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacityC)
                                    } else if gestaltVM.sectionD.contains(index) {
                                        FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacityD)
                                    } else {
                                        if gestaltVM.totalOpacity <= 0.0 {
                                            Button {
                                                withAnimation {
                                                    if !gestaltVM.clearedPrinciples.contains(Constants.Gestalt.SIMILARITY) {
                                                        gestaltVM.similarityPuzzleCleared = true
                                                    }
                                                }
                                            } label: {
                                                Text("🌼")
                                                    .font(.largeTitle)
                                                    .frame(
                                                        maxWidth: Constants.ReactiveCGFloat.REACTIVE_WIDTH / 8,
                                                        maxHeight: Constants.ReactiveCGFloat.REACTIVE_HEIGHT / 8
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
                                        } else {
                                            Text("")
                                                .font(.largeTitle)
                                                .frame(
                                                    maxWidth: Constants.ReactiveCGFloat.REACTIVE_WIDTH / 8,
                                                    maxHeight: Constants.ReactiveCGFloat.REACTIVE_HEIGHT / 8
                                                )
                                                .overlay {
                                                    Circle()
                                                        .stroke(
                                                            style: StrokeStyle(
                                                                lineWidth: 3, dash: [5]
                                                            )
                                                        )
                                                }
                                        }
                                    }
                                }
                                else if index >= 32 { // 32~63: 31
                                    if gestaltVM.section1.contains(index) {
                                        FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacity1)
                                    } else if gestaltVM.section2.contains(index) {
                                        FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacity2)
                                    } else if gestaltVM.section3.contains(index) {
                                        FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacity3)
                                    } else if gestaltVM.section4.contains(index) {
                                        FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacity4)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .frame(
                maxHeight: .infinity,
                alignment: .top
            )
            
            if gestaltVM.similarityPuzzleCleared {
                MiniFlower(tintColor: Color("SummerTint"), budColor: .yellow, radian: 2)
                    .modifier(ParticlesModifier(numberOfParticles: 15))
                
                MiniFlower(tintColor: Color.yellow, budColor: .brown, radian: 2)
                    .modifier(ParticlesModifier(numberOfParticles: 15))
            }
        }
        .padding(.horizontal, getPadding())
        .onAppear {
            if !gestaltVM.isFirstDisplayedSimilarity {
                isFirstDisplayed.toggle()
            }
        }
        .overlay(alignment: .bottom) {
            if gestaltVM.clearedPrinciples.contains(Constants.Gestalt.SIMILARITY) {
                DismissButton()
            }
        }
        .show(isActivated: $isFirstDisplayed) {
            FMCustomCardView(style: .normal()) {
                VStack {
                    Text(
                        """
                        Welcome to the Gestalt Principle of **Similarity**!
                        
                        Here, You can see lots of flowers without a color.
                        Let me tell you that those flowers are slightly different.
                        And You should find a missing flowers color!
                        
                        While You interact with flowers, you possibly know the color of the missing flower.
                        
                        Long press the flowers, and find a missing flower!
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
                        gestaltVM.isFirstDisplayedSimilarity = true
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
        .show(isActivated: $gestaltVM.similarityPuzzleCleared) {
            FMCustomCardView(style: .normal()) {
                VStack {
                    Text(
                         """
                        🎉 Conguratulations!
                        
                        You have cleared The Gestalt Principle of **Similarity**!
                        
                        You might noticed that missing flower is next to other yellow ones.
                        So it is so natural to thinking like this:
                        missing flower's color is yellow, too!
                        
                        Because our brain naturally makes a relationship between similar figures.
                        If Shape, Color or Size is similar, there's no difficult to think
                        those similar things might have a relationship!
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
                    gestaltVM.clearedPrinciples.append(Constants.Gestalt.SIMILARITY)
                }
            }
            .overlay(alignment: .bottom) {
                Button {
                    withAnimation {
                        gestaltVM.similarityPuzzleCleared.toggle()
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
    
    private func getPadding() -> CGFloat {
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            return UIScreen.main.bounds.width / 5
        } else {
            return 0
        }
    }
    
    @ViewBuilder
    private func descriptionBuild() -> some View {
        if gestaltVM.clearedPrinciples.contains(Constants.Gestalt.SIMILARITY) {
            Text("You have cleared this Principle!")
                .bold()
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(.accentColor)
                .padding()
        } else if gestaltVM.totalOpacity <= 0.0 {
            Text("Look! You have found a yellow Sunflower!")
                .bold()
                .multilineTextAlignment(.center)
                .foregroundColor(.accentColor)
                .font(.title)
                .padding()
            
        }
        else if gestaltVM.totalOpacity <= 1.75 {
            Text("Because it is near by other yellow Sunflowers!")
                .bold()
                .multilineTextAlignment(.center)
                .foregroundColor(.accentColor)
                .font(.title)
                .padding()
        }
        else if gestaltVM.totalOpacity <= 3.5 {
            Text("It maybe has a yellow color...")
                .bold()
                .multilineTextAlignment(.center)
                .foregroundColor(.accentColor)
                .font(.title)
                .padding()
        }
        else if gestaltVM.totalOpacity <= 5.0 {
            Text("Can you guess the color of the missing Sunflower?")
                .bold()
                .multilineTextAlignment(.center)
                .foregroundColor(.accentColor)
                .font(.title)
                .padding()
        } else {
            Text("Hold the colorless Flowers to find a missing Sunflower!")
                .bold()
                .multilineTextAlignment(.center)
                .foregroundColor(.accentColor)
                .font(.title)
                .padding()
        }
        
    }
}

struct FlowerCurtain: View {
    var timer: AnyPublisher<Date, Never>
    let index: Int
    @State private var isPressing: Bool = false
    @Binding var circleOpacity: CGFloat
    
    var body: some View {
        ZStack {
            MiniFlower(
                tintColor: index < 32 ? Color.yellow : Color("SummerTint"),
                budColor: index < 32 ? Color.brown : Color.yellow,
                radian: index < 32 ? 15 : 2
            )
            
            MiniFlower(
                tintColor: .primary,
                budColor: .primary,
                radian: index < 32 ? 15 : 2
            )
            .onReceive(timer, perform: { _ in
                if isPressing, circleOpacity > 0.0 {
                    withAnimation {
                        circleOpacity -= 0.25
                    }
                }
            })
            .opacity(circleOpacity)
            .onLongPressGesture(minimumDuration: .infinity) {
                
            } onPressingChanged: { isPressing in
                if isPressing {
                    self.isPressing = isPressing
                } else if !isPressing {
                    self.isPressing = isPressing
                }
            }
        }
    }
}

struct SimilaryityPreview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SimilarityView(gestaltVM: GestaltVM())
                .navigationTitle("제목임")
        }
        .navigationViewStyle(.stack)
        .previewInterfaceOrientation(.landscapeRight)
    }
}

