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
    
    @State private var sectionA = [Int]()
    @State private var circleOpacityA: CGFloat = 1.0
    @State private var sectionB = [Int]()
    @State private var circleOpacityB: CGFloat = 1.0
    @State private var sectionC = [Int]()
    @State private var circleOpacityC: CGFloat = 1.0
    @State private var sectionD = [Int]()
    @State private var circleOpacityD: CGFloat = 1.0
    @State private var sectionE = [Int]()
    @State private var circleOpacityE: CGFloat = 1.0
    
    @State private var section1 = [Int]()
    @State private var circleOpacity1: CGFloat = 1.0
    @State private var section2 = [Int]()
    @State private var circleOpacity2: CGFloat = 1.0
    @State private var section3 = [Int]()
    @State private var circleOpacity3: CGFloat = 1.0
    @State private var section4 = [Int]()
    @State private var circleOpacity4: CGFloat = 1.0
    @State private var section5 = [Int]()
    @State private var circleOpacity5: CGFloat = 1.0
    
    var timer = Timer.publish(every: 0.2, on: .main, in: .common)
        .autoconnect()
        .eraseToAnyPublisher()
    
    let gridItem: [GridItem] = Array(
        repeating: .init(
            .flexible(),
            spacing: 10
        ),
        count: 8
    )
    
    var body: some View {
        VStack {
            if gestaltVM.totalOpacity <= 0.0 {
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
            }
            else {
                Text("Hold Your Bud to find a missing Sunflower!")
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.accentColor)
                    .font(.title)
                    .padding()
            }
            
            ZStack {
                LazyVGrid(columns: gridItem, spacing: 10) {
                    ForEach(0..<80, id: \.self) { index in
                        ZStack {
                            if index < 40 {
                                if gestaltVM.sectionA.contains(index) {
                                    FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacityA)
                                } else if gestaltVM.sectionB.contains(index) {
                                    FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacityB)
                                } else if gestaltVM.sectionC.contains(index) {
                                    FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacityC)
                                } else if gestaltVM.sectionD.contains(index) {
                                    FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacityD)
                                } else if gestaltVM.sectionE.contains(index) {
                                    FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacityE)
                                }
                            } else if index >= 40 {
                                if gestaltVM.section1.contains(index) {
                                    FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacity1)
                                } else if gestaltVM.section2.contains(index) {
                                    FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacity2)
                                } else if gestaltVM.section3.contains(index) {
                                    FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacity3)
                                } else if gestaltVM.section4.contains(index) {
                                    FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacity4)
                                } else if gestaltVM.section5.contains(index) {
                                    FlowerCurtain(timer: timer, index: index, circleOpacity: $gestaltVM.circleOpacity5)
                                } else {
                                    if gestaltVM.totalOpacity <= 0.0 {
                                        Button {
                                            withAnimation {
                                                if !gestaltVM.clearedPrinciples.contains(Constants.Gestalt.SIMILARITY) {
                                                    gestaltVM.similarityPuzzleCleared = true
                                                    gestaltVM.clearedPrinciples.append(Constants.Gestalt.SIMILARITY)
                                                }
                                            }
                                        } label: {
                                            Text("🌼")
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
                                    } else {
                                        Text("")
                                            .font(.largeTitle)
                                            .frame(
                                                maxWidth: UIScreen.main.bounds.width / 8,
                                                maxHeight: UIScreen.main.bounds.height / 8
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
                        }
                    }
                }
                
                if gestaltVM.similarityPuzzleCleared {
                    MiniFlower(tintColor: Color("SummerTint"), budColor: .yellow, radian: 2)
                        .modifier(ParticlesModifier(numberOfParticles: 15))
                    
                    MiniFlower(tintColor: Color.yellow, budColor: .brown, radian: 2)
                        .modifier(ParticlesModifier(numberOfParticles: 15))
                }
            }
            
            Spacer()
        }
        .onAppear {
            if !gestaltVM.isFirstDisplayedSimilarity {
                isFirstDisplayed.toggle()
            }
        }
        .show(isActivated: $isFirstDisplayed) {
            FMCustomCardView(style: .large()) {
                VStack {
                    Text(
                        """
                        Welcome to the Gestalt Principle of **Similarity**!
                        
                        내용추가필
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
            FMCustomCardView(style: .large()) {
                VStack {
                    Text(
                         """
                        Conguratulations!
                        
                        You have cleared The Gestalt Principle of **Similarity**!
                        
                        // TODO: - 설명써줘
                        And this is a **Sunflower** badge for You!
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
    
    private func sectionMaker() {
        var firstSection = (0...39).map { $0 }
        var secondSeection = (40...80).map { $0 }
        
        for index in 0..<5 {
            switch index {
            case 0:
                appendEachSection(in: &sectionA, from: &firstSection)
            case 1:
                appendEachSection(in: &sectionB, from: &firstSection)
            case 2:
                appendEachSection(in: &sectionC, from: &firstSection)
            case 3:
                appendEachSection(in: &sectionD, from: &firstSection)
            case 4:
                appendEachSection(in: &sectionE, from: &firstSection)
            default:
                break
            }
        }
        
        for index in 0..<5 {
            switch index {
            case 0:
                appendEachSection(in: &section1, from: &secondSeection)
            case 1:
                appendEachSection(in: &section2, from: &secondSeection)
            case 2:
                appendEachSection(in: &section3, from: &secondSeection)
            case 3:
                appendEachSection(in: &section4, from: &secondSeection)
            case 4:
                appendEachSection(in: &section5, from: &secondSeection)
            default:
                break
            }
        }
    }
    
    private func appendEachSection(
        in arr: inout [Int],
        from arr2: inout [Int]
    ) {
        for _ in 0..<8 {
            arr.append(
                arr2.remove(
                    at: arr2.firstIndex(
                        of: arr2.randomElement() ?? 0
                    ) ?? 0
                )
            )
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
                tintColor: index >= 40 ? Color.yellow : Color("SummerTint"),
                budColor: index >= 40 ? Color.brown : Color.yellow,
                radian: index >= 40 ? 2 : 15
            )
            
            MiniFlower(
                tintColor: .primary,
                budColor: .primary,
                radian: index >= 40 ? 2 : 15
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
    }
}

