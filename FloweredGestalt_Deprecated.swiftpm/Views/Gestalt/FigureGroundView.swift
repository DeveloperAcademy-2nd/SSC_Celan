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
                            index: index
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
            }
        }
        .overlay {
            if gestaltVM.figureGroundPuzzleCleared {
                FivePetalsFlower(
                    petalOffset: 0,
                    petalWidth: 40
                )
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
                    .scaleEffect(0.8)
                    .frame(width: 150, height: 150)
                    .modifier(ParticlesModifier(numberOfParticles: 24))
            }
        }
        .overlay(alignment: .bottom) {
            if gestaltVM.clearedPrinciples.contains(Constants.Gestalt.FIGUREGROUND) {
                DismissButton()
            }
        }
        .onAppear {
            if !gestaltVM.isFirstDisplayedFigrueGround {
                isFirstDisplayed.toggle()
            }
        }
        .show(isActivated: $isFirstDisplayed) {
            FMCustomCardView(style: .normal()) {
                VStack {
                    Text(
                        """
                        Welcome to the Gestalt Principle of **Figure And Ground**!
                        
                        Here, You should long press the black flower to get its color back.
                        While You are long pressing the flower, it will become more clear, either.
                        
                        But What would happen to the background flowers?
                        Will they be still clearly focused?
                        
                        Let's find out!
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
            FMCustomCardView(style: .normal()) {
                VStack {
                    Text(
                        """
                        💐 Conguratulations!
                        
                        You have cleared The Gestalt Principle of **Figure/Ground**!
                        
                        According to this principle,
                        you can recognize things as either being in the foreground or the background.
                        
                        While you press the main flower, it becomes foreground!
                        In real life, **Figure And Ground** principle is commonly used.
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
    
    var body: some View {
        FivePetalsFlower()
            .fill(
                index % 3 == 0
                ? Color("WinterTint").opacity(0.7)
                : Color.white
            )
            .scaleEffect(UIScreen.main.bounds.width > UIScreen.main.bounds.height ? 0.3 : 0.8)
//            .id("index")
            .shadow(radius: 10)
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
    var timer = Timer.publish(every: 0.15, on: .main, in: .common)
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
            .scaleEffect(UIScreen.main.bounds.width > UIScreen.main.bounds.height ? 0.3 : 0.8)
            .blur(radius: blurIntensity)
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
                            gestaltVM.backgroundBlurIntensity.value - 0.2
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
                        width: Constants.ReactiveCGFloat.REACTIVE_WIDTH / 2,
                        height: Constants.ReactiveCGFloat.REACTIVE_HEIGHT / 2.25
                    )
//                    .opacity(
//                        blurIntensity < 6.0
//                        ? 1
//                        : 0
//                    )
                    .shadow(radius: 10)
                    .overlay(alignment: .top) {
                        if !gestaltVM.clearedPrinciples.contains(Constants.Gestalt.FIGUREGROUND) {
                            if blurIntensity > 8.0 { // maximum
                                Text("Press and hold the black flower \nto get its original color!")
                                    .bold()
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            } else if blurIntensity <= 2.0 { // minimum
                                Text("Yay! We did it, Look how clear it is!")
                                    .bold()
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            } else if blurIntensity <= 5.5 { // blooming
                                Text("Look! Your Sakura is blooming! \nBut it's still blurred!")
                                    .bold()
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            } else if blurIntensity <= 8.0 {
                                Text("Keep Holding! \nYour Flower is about to bloom!")
                                    .bold()
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                        } else {
                            Text("You have cleared this principle!\nTap Your Flower Icon!")
                                .bold()
                                .font(.title)
                                .foregroundColor(.accentColor)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        
                    }
                    .overlay(alignment: .bottom) {
                        if blurIntensity > 8.0 { // maximum
                            Text("You should focus on your flower.")
                                .bold()
                                .font(.title)
                                .foregroundColor(.accentColor)
                                .multilineTextAlignment(.center)
                                .padding()
                        } else if blurIntensity <= 2.0 { // minimum
                            Text("Finally, You can get Sakura colors back!")
                                .bold()
                                .font(.title)
                                .foregroundColor(.accentColor)
                                .multilineTextAlignment(.center)
                                .padding()
                        } else if blurIntensity <= 5.5 { // blooming
                            Text("Let's make it more clear!")
                                .bold()
                                .font(.title)
                                .foregroundColor(.accentColor)
                                .multilineTextAlignment(.center)
                                .padding()
                        } else if blurIntensity <= 8.0 {
                            Text("What color is it? Yellow? Pink?")
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
