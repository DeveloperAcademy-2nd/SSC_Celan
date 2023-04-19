//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/05.
//

import SwiftUI

struct PragnanzView: View {
    @ObservedObject var gestaltVM: GestaltVM
    @State private var petalWidth: CGFloat = 80.0
    @State private var petalOffset: CGFloat = -40.0
    @State private var isFirstDisplayed: Bool = false
    @State private var isPetalWidthMaxed: Bool = false
    @State private var isPetalOffsetMaxed: Bool = false
    
    var total: CGFloat {
        petalOffset + petalWidth
    }
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    descriptionBuild()
                        .frame(
                            minHeight: 100,
                            alignment: .top
                        )
                    
                    Slider(value: $petalWidth, in: 80...200, onEditingChanged: { _ in
                        if petalWidth == 200 {
                            withAnimation(.linear(duration: 0.7)) {
                                isPetalWidthMaxed.toggle()
                            }
                        }
                    })
                    .disabled(petalWidth == 200)
                    .padding(.horizontal, 32)
                    .padding()
                    
                    Slider(value: $petalOffset, in: -40...60, onEditingChanged: { _ in
                        if petalOffset == 60 {
                            withAnimation(.linear(duration: 0.7)) {
                                isPetalOffsetMaxed.toggle()
                            }
                        }
                    })
                    .disabled(petalOffset == 60)
                    .padding(.horizontal, 32)
                    .padding()
                    
                    Spacer()
                    
                    TransformableFlower(
                        petalOffset: petalOffset,
                        petalWidth: petalWidth
                    )
                    .fill(
                        isPetalWidthMaxed && isPetalOffsetMaxed
                        ? LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    .red,
                                    Color(
                                        red: 253/255,
                                        green: 61/255,
                                        blue: 86/255
                                    ),
                                    Color(
                                        red: 253/255,
                                        green: 185/255,
                                        blue: 109/255
                                    )
                                ]
                            ),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        
                        : LinearGradient(
                            gradient: Gradient(colors: [
                                Color.black
                            ]),
                            startPoint: .top,
                            endPoint: .top
                        ),
                        style: .init(
                            eoFill: isPetalWidthMaxed && isPetalOffsetMaxed ? false : true
                        )
                    )
                    .scaleEffect(UIScreen.main.bounds.width > UIScreen.main.bounds.height ? 0.3 : 0.8)
                    .overlay {
                        if isPetalWidthMaxed, isPetalOffsetMaxed {
                            Button {
                                withAnimation {
                                    if !gestaltVM.clearedPrinciples.contains(Constants.Gestalt.PRAGNANZ) {
                                        gestaltVM.pragnanzPuzzleCleared = true
                                    }
                                }
                            } label: {
                                Text("🌺")
                                    .font(.system(size: Constants.ReactiveCGFloat.REACTIVE_WIDTH / 10))
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
                        }
                    }
                }
            }
            
            if gestaltVM.pragnanzPuzzleCleared {
                TransformableFlower(
                    petalOffset: 5,
                    petalWidth: 20
                )
                    .fill(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    .red,
                                    Color(
                                        red: 253/255,
                                        green: 61/255,
                                        blue: 86/255
                                    ),
                                    Color(
                                        red: 253/255,
                                        green: 185/255,
                                        blue: 109/255
                                    )
                                ]
                            ),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)
                    .modifier(ParticlesModifier(numberOfParticles: 10))
                
                Text("🌺")
                    .font(.largeTitle)
                    .modifier(ParticlesModifier())
            }
        }
        .onAppear {
            if !gestaltVM.isFirstDisplayedPragnanz {
                isFirstDisplayed.toggle()
            }
        }
        .show(isActivated: $isFirstDisplayed) {
            FMCustomCardView(style: .normal()) {
                VStack {
                    Text(
                        """
                        Welcome to the Gestalt Principle of **Prägnanz**!
                        
                        Whoa, can you see that little complicated pieces?
                        We should organize those pieces with our Sliders.
                        
                        Now grab the knob of the slider, and drag to the top.
                        While you are doing this task, you can relize that,
                        It really looks like a flower.
                        
                        Does it?
                        Let's take a closer look at the Flower!
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
                        gestaltVM.isFirstDisplayedPragnanz = true
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
        .show(isActivated: $gestaltVM.pragnanzPuzzleCleared) {
            // TODO: - 여기다가 클리어 카드 넣어
            FMCustomCardView(style: .normal()) {
                VStack {
                    Text(
                        """
                        🎉 Conguratulations!
                        
                        You have cleared The Gestalt Principle of **Prägnanz**!
                        
                        As you can see, you really don't give a attention to little pieces.
                        It is hard to be understand if we care all of them.
                        
                        This principle is also known as "the Principle of Good form".
                        
                        It says that We prefer experiences that are simple and
                        when we face complicated figure, our brain can simplify it!
                        
                        Because of that specific ability, You can recognize that figure as a flower!
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
                    gestaltVM.clearedPrinciples.append(Constants.Gestalt.PRAGNANZ)
                }
            }
            .overlay(alignment: .bottom) {
                    Button {
                        withAnimation {
                            gestaltVM.pragnanzPuzzleCleared.toggle()
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
    
    @ViewBuilder
    private func descriptionBuild() -> some View {
        if gestaltVM.clearedPrinciples.contains(Constants.Gestalt.PRAGNANZ) {
            Text("You have cleared this principle!")
                .bold()
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(.accentColor)
                .padding()
        }
        // 0 ~ 260
        else if isPetalWidthMaxed, isPetalOffsetMaxed {
           Text("And Voilà! \nAll complicate pieces are now part of the Flower!")
               .bold()
               .font(.title)
               .multilineTextAlignment(.center)
               .foregroundColor(.accentColor)
               .padding()
            
       } else if total <= 40 { // 시작
           Text("Move the Knob to the end!")
               .bold()
               .font(.title)
               .foregroundColor(.accentColor)
               .padding()
           
       } else if total <= 80 { // 시작점
           Text("It has complecated figures but...")
               .bold()
               .font(.title)
               .foregroundColor(.accentColor)
               .padding()
           
       } else if total <= 140 { // 둘 중 하나가 움직이고 있을 때
           Text("You know it is a Flower, right?")
               .bold()
               .font(.title)
               .foregroundColor(.accentColor)
               .padding()
           
       } else if total <= 200 {
           Text("You don't care that little but complicate pieces.")
               .bold()
               .font(.title)
               .multilineTextAlignment(.center)
               .foregroundColor(.accentColor)
               .padding()
       } else {
           Text("Because You recognize this whole figure\nas easy as possible!")
               .bold()
               .font(.title)
               .multilineTextAlignment(.center)
               .foregroundColor(.accentColor)
               .padding()
       }
    }
}

struct PragnanzPreview: PreviewProvider {
    static var previews: some View {
        PragnanzView(gestaltVM: GestaltVM())
    }
}
