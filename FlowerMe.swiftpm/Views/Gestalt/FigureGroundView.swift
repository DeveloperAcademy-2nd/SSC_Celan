//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/05.
//

import SwiftUI

struct FigureGroundView: View {
    @ObservedObject var gestaltVM: GestaltVM
    @State private var blurIntensity: CGFloat = 10.0
    @State private var isFirstDisplayed: Bool = false
    let numberOfPetals: Int = 30
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if isFirstDisplayed {
                    Color(.systemBackground)
                } else if gestaltVM.figureGroundPuzzleCleared
                            || gestaltVM.clearedPrinciples.contains(Constants.Gestalt.FIGUREGROUND) {
                    Color(.systemBackground)
                } else if !gestaltVM.clearedPrinciples.contains(Constants.Gestalt.FIGUREGROUND),
                          !gestaltVM.figureGroundPuzzleCleared { // in play
                    ForEach(gestaltVM.backgroundPetalList, id: \.self) { index in
                        BackgroundPetals(
                            gestaltVM: gestaltVM,
                            index: index,
                            proxy: proxy
                        )
                        .position(
                            CGPoint(
                                x: CGFloat.random(in: 0...proxy.size.width),
                                y: CGFloat.random(in: 0...proxy.size.height)
                            )
                        )
                        .onReceive(gestaltVM.backgroundBlurIntensity) {
                            self.blurIntensity = $0
                        }
                    }
                }
                
                FigurePetalView(gestaltVM: gestaltVM)
                
                if gestaltVM.figureGroundPuzzleCleared {
                    FivePetalsFlower()
                        .fill(
                            LinearGradient(
                                gradient:
                                    Gradient(
                                        colors: [
                                            Color(red: 245/255, green: 35/255, blue: 47/255),
                                            Color(red: 255/255, green: 214/255, blue: 158/255)
                                        ]
                                    ),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .scaleEffect(0.6)
                        .modifier(ParticlesModifier(numberOfParticles: 10))
                }
            }
        }
        .onAppear {
            if !gestaltVM.isFirstDisplayedPragnanz {
                isFirstDisplayed.toggle()
            }
        }
        .show(isActivated: $isFirstDisplayed) {
            FMCustomCardView(style: .large()) {
                VStack {
                    Text(
                        """
                        Welcome to the Gestalt Principle of **Figure/Ground**!
                        
                        TODO: 내용추가하기
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
                    withAnimation(.easeInOut(duration: 0.6)) {
                        gestaltVM.isFirstDisplayedFigrueGround = true
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
        .show(isActivated: $gestaltVM.figureGroundPuzzleCleared) {
            FMCustomCardView(style: .large()) {
                VStack {
                    Text(
                        """
                        Conguratulations!
                        
                        You have cleared The Gestalt Principle of **Figure/Ground**!
                        
                        // TODO: 내용추가
                        And this is a **Sakura** badge for You!
                        """
                    )
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 64)

                }
                .padding(24)
                .frame(maxHeight: .infinity)
            }
            .onDisappear {
                withAnimation {
                    gestaltVM.clearedPrinciples.append(Constants.Gestalt.FIGUREGROUND)
                }
            }
            .overlay(alignment: .bottom) {
                    Button {
                        withAnimation {
                            gestaltVM.figureGroundPuzzleCleared.toggle()
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

struct FigureGround: PreviewProvider {
    static var previews: some View {
        FigureGroundView(gestaltVM: GestaltVM())
    }
}

struct BackgroundPetals: View {
    @ObservedObject var gestaltVM: GestaltVM
    @State private var blurIntensity: CGFloat = 10.0
    let index: Int
    let proxy: GeometryProxy
    
    var body: some View {
        FivePetalsFlower()
            .fill(
                index % 5 == 0
                ? Color("WinterTint").opacity(0.7)
                : Color.white
            )
            .id("index")
            .shadow(radius: 10)
            .scaleEffect(0.6)
            .overlay {
                Circle()
                    .colorInvert()
                    .frame(
                        width: 50
                    )
                    .shadow(radius: 3)
            }
            .blur(radius: 6 - blurIntensity)
            .onReceive(gestaltVM.backgroundBlurIntensity) {
                self.blurIntensity = $0
            }
    }
}

struct FigurePetalView: View {
    var timer = Timer.publish(every: 0.2, on: .main, in: .common)
        .autoconnect()
        .eraseToAnyPublisher()
    
    @ObservedObject var gestaltVM: GestaltVM
    @State private var blurIntensity: CGFloat = 10.0
    @State private var isLongPressing: Bool = false
    
    var body: some View {
        FivePetalsFlower()
            .fill(
                blurIntensity < 6.0
                ? LinearGradient(
                    gradient:
                        Gradient(
                            colors: [
                                Color(red: 245/255, green: 35/255, blue: 47/255),
                                Color(red: 255/255, green: 214/255, blue: 158/255)
                            ]
                        ),
                    startPoint: .top,
                    endPoint: .bottom
                )
                : LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black
                    ]),
                    startPoint: .top,
                    endPoint: .top
                )
            )
            .scaleEffect(0.8)
            .blur(radius: blurIntensity - 2)
            .overlay {
                Circle()
                    .colorInvert()
                    .frame(
                        width: 50
                    )
                    .shadow(radius: 3)
                    .blur(radius: blurIntensity - 2)
            }
            .shadow(radius: 15)
            .onLongPressGesture(minimumDuration: .infinity) {
                isLongPressing.toggle()
            } onPressingChanged: { _ in
                isLongPressing.toggle()
            }
            .onReceive(timer) { _ in
                if isLongPressing, blurIntensity > 0.0 {
                    withAnimation {
                        gestaltVM.backgroundBlurIntensity.send(
                            gestaltVM.backgroundBlurIntensity.value - 0.5
                        )
                    }
                }
            }
            .onReceive(gestaltVM.backgroundBlurIntensity) { value in
                withAnimation(.linear(duration: 0.5)) {
                    self.blurIntensity = value
                }
            }
            .overlay {
                if blurIntensity <= 2.0 {
                    Button {
                        withAnimation {
                            if !gestaltVM.clearedPrinciples.contains(Constants.Gestalt.FIGUREGROUND) {
                                gestaltVM.figureGroundPuzzleCleared = true
                            }
                        }
                    } label: {
                        Text("🌸")
                            .font(.largeTitle)
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
            }
            .background {
                // Card
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .frame(
                        width: UIScreen.main.bounds.width / 2,
                        height: UIScreen.main.bounds.height / 2
                    )
                    .opacity(
                        blurIntensity < 6.0
                        ? 1
                        : 0
                    )
                    .shadow(radius: 10)
                    .overlay(alignment: .top) {
                        if blurIntensity > 6.0 {
                            Text("Press and hold the black flower \nto get its original color!")
                                .bold()
                                .font(.title)
                                .foregroundColor(.accentColor)
                                .multilineTextAlignment(.center)
                            
                        } else if blurIntensity <= 2.0 {
                            Text("Your Sakura gets its original Color!")
                                .bold()
                                .font(.title)
                                .foregroundColor(.accentColor)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    }
                    .overlay(alignment: .bottom) {
                        if blurIntensity <= 2.0 {
                            Text("And Background is now Blurred!")
                                .bold()
                                .font(.title)
                                .foregroundColor(.accentColor)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    }
            }
    }
}
