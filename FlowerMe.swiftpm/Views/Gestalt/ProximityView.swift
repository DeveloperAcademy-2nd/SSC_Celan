//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/05.
//

import SwiftUI

struct ProximityView: View {
    @ObservedObject var gestaltVM: GestaltVM
    
    @State private var isTapped: Bool = false
    @State private var randomIndex: Int = -1
    // index처럼 0을 기준으로 함
    @State private var horizontalPosition: Int = 0
    @State private var verticalPosition: Int = 0
    
    @State private var isFirstDisplayed: Bool = false
    
    let gridItem: [GridItem] = Array(
        repeating: .init(
            .flexible(),
            spacing: 10
        ),
        count: 8
    )
    
    var body: some View {
        // TODO: - 클리어한 이후 다시 들어왔을 때 거멓게 되어있는 이슈.
        VStack {
            ZStack {
                LazyVGrid(columns: gridItem, spacing: 10) {
                    ForEach(0..<80, id: \.self) { index in
                        if !isTapped {
                            Circle()
                                .overlay {
                                    if index == randomIndex {
                                        Button {
                                            withAnimation {
                                                isTapped.toggle()
                                            }
                                        } label: {
                                            Text("Tap!")
                                                .bold()
                                                .font(.title2)
                                        }
                                    }
                                }
                        } else {
                            if isEmptyCirclePosition(in: index) {
                                Circle()
                                    .fill(Color(.systemBackground))
                                    .frame(
                                        maxWidth: UIScreen.main.bounds.width / 9,
                                        maxHeight: UIScreen.main.bounds.height / 5
                                    )
                                    .overlay {
                                        /**
                                        index가
                                         18~21, 26~29, 34~37, 42~45, 50-53, 58-61,
                                         일 때, 랜덤으로 한 곳에만 오버레이 한다.
                                         */
                                        if index == randomIndex {
                                            if !gestaltVM.clearedPrinciples.contains(Constants.Gestalt.PROXIMITY) {
                                                Button {
                                                    withAnimation {
                                                        gestaltVM.proximityPuzzleCleared.toggle()
                                                    }
                                                } label: {
                                                    Text("💐")
                                                        .bold()
                                                        .font(.largeTitle)
                                                        .padding()
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
                            } else {
                                if checkIfEachSideToShow(in: index) == 1 {
                                    MiniFlower(tintColor: .yellow, budColor: .white, radian: 2)
                                } else if checkIfEachSideToShow(in: index) == 2 {
                                    FivePetalsFlower(
                                        petalOffset: 0,
                                        petalWidth: 40
                                    )
                                        .fill(Color.red)
                                } else if checkIfEachSideToShow(in: index) == 3 {
                                    TransformableFlower(
                                        petalOffset: 0,
                                        petalWidth: 20
                                    )
                                        .fill(Color.purple)
                                } else if checkIfEachSideToShow(in: index) == 4 {
                                    FMFlower(tintColor: .orange, budColor: .yellow)
                                        .scaleEffect(0.5)
                                }
                            }
                        }
                    }
                }
                
                if gestaltVM.proximityPuzzleCleared {
                        MiniFlower(tintColor: .yellow, budColor: .white, radian: 2)
                            .modifier(ParticlesModifier(numberOfParticles: 10))
                        
                        FivePetalsFlower(petalOffset: 0, petalWidth: 40)
                            .fill(Color.red)
                            .frame(width: 100, height: 100)
                            .modifier(ParticlesModifier(numberOfParticles: 10))
                        
                        TransformableFlower(
                            petalOffset: 0,
                            petalWidth: 20
                        )
                            .fill(Color.purple)
                            .frame(width: 100, height: 100)
                            .modifier(ParticlesModifier(numberOfParticles: 10))
                    
                        FMFlower(tintColor: .orange, budColor: .yellow)
                            .scaleEffect(0.5)
                            .modifier(ParticlesModifier(numberOfParticles: 10))
                }
            }
            .onAppear {
                if !gestaltVM.clearedPrinciples.contains(Constants.Gestalt.PROXIMITY) {
                    randomIndex = [
                        Range(18...21).randomElement(),
                        Range(26...29).randomElement(),
                        Range(34...37).randomElement(),
                        Range(42...45).randomElement(),
                        Range(50...53).randomElement(),
                        Range(58...61).randomElement()
                    ]
                        .randomElement()! ?? 0
                    
                    var res = randomIndex
                    
                    // get verticalPosition
                    while res >= 8 {
                        res -= 8
                        verticalPosition += 1
                    }
                    
                    res = randomIndex
                    horizontalPosition = res % 8
                }
            }
        }
        .padding()
        .onAppear {
            if !gestaltVM.isFirstDisplayedProximity {
                isFirstDisplayed.toggle()
            }
        }
        .show(isActivated: $isFirstDisplayed) {
            FMCustomCardView(style: .large()) {
                VStack {
                    Text(
                        """
                        Welcome to the Gestalt Principle of **Proximity**!
                        
                        Here, You can tap random Ball with a "Tap!" Message.
                        This Gestalt Priciple is one of the simplest one,
                        so you can immediately understand what it means.
                        
                        Go ahead!
                        Tap a Ball and get Your Badges!
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
                        gestaltVM.isFirstDisplayedProximity = true
                        isFirstDisplayed.toggle()
                    }
                } label: {
                    Text("Got It!")
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
        .show(isActivated: $gestaltVM.proximityPuzzleCleared) {
            FMCustomCardView(style: .large()) {
                VStack {
                    Text(
                        """
                        Conguratulations!
                        
                        You have cleared The Gestalt Principle of **Proximity**!
                        
                        The Gestalt Principle of Proximity states that
                        the closer things are, the more related things seem.
                        
                        And, Yes!
                        There is garden divided into quarters,
                        each decorated with different flowers!
                        
                        And now you have a **Garden** badge!
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
                    gestaltVM.clearedPrinciples.append(Constants.Gestalt.PROXIMITY)
                }
            }
            .overlay(alignment: .bottom) {
                    Button {
                        withAnimation {
                            gestaltVM.proximityPuzzleCleared.toggle()
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
    
    /**
     index의 위치를 바탕으로 해당 인덱스가 비어있어야 하는 위치의 인덱스인지 연산한 후,  조건에 따라 비어있어야 하는 공간에서 true를 리턴
     */
    private func isEmptyCirclePosition(
        in index: Int
    ) -> Bool {
        if index == horizontalPosition + 8 * 0
            || index == horizontalPosition + 8 * 1
            || index == horizontalPosition + 8 * 2
            || index == horizontalPosition + 8 * 3
            || index == horizontalPosition + 8 * 4
            || index == horizontalPosition + 8 * 5
            || index == horizontalPosition + 8 * 6
            || index == horizontalPosition + 8 * 7
            || index == horizontalPosition + 8 * 8
            || index == horizontalPosition + 8 * 9
            || index == horizontalPosition + 8 * 10 {
            return true
            // 48 < 52 < 55 true, else false
        } else if index >= (verticalPosition) * 8, index < (verticalPosition + 1) * 8 {
            return true
        }
        return false
    }
    
    /**
     현재 인덱스가 어느 사분면에 해당하는지 확인하기 위한 메소드
     사분면 위치를 리턴한다.
     */
    private func checkIfEachSideToShow(
        in index: Int
    ) -> Int {
        if index < verticalPosition * 8 {
            if index < 8 * 0 + horizontalPosition
                || index >= 8 * 1, index < 8 * 1 + horizontalPosition
                || index >= 8 * 2, index < 8 * 2 + horizontalPosition
                || index >= 8 * 3, index < 8 * 3 + horizontalPosition
                || index >= 8 * 4, index < 8 * 4 + horizontalPosition
                || index >= 8 * 5, index < 8 * 5 + horizontalPosition
                || index >= 8 * 6, index < 8 * 6 + horizontalPosition
                || index >= 8 * 7, index < 8 * 7 + horizontalPosition
                || index >= 8 * 8, index < 8 * 8 + horizontalPosition
                || index >= 8 * 9, index < 8 * 9 + horizontalPosition {
                return 2
            } else {
                return 1
            }
        } else if index > verticalPosition * 8 {
            if index < 8 * 0 + horizontalPosition
                || index >= 8 * 1, index < 8 * 1 + horizontalPosition
                || index >= 8 * 2, index < 8 * 2 + horizontalPosition
                || index >= 8 * 3, index < 8 * 3 + horizontalPosition
                || index >= 8 * 4, index < 8 * 4 + horizontalPosition
                || index >= 8 * 5, index < 8 * 5 + horizontalPosition
                || index >= 8 * 6, index < 8 * 6 + horizontalPosition
                || index >= 8 * 7, index < 8 * 7 + horizontalPosition
                || index >= 8 * 8, index < 8 * 8 + horizontalPosition
                || index >= 8 * 9, index < 8 * 9 + horizontalPosition {
                return 3
            } else {
                return 4
            }
        }
        return 0
    }
}

struct Proxy: PreviewProvider {
    static var previews: some View {
        ProximityView(gestaltVM: GestaltVM())
    }
}
