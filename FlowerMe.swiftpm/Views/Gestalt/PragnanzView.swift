//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/05.
//

import SwiftUI

struct PragnanzView: View {
    @ObservedObject var gestaltVM: GestaltVM
    @State private var petalWidth: CGFloat = 40.0
    @State private var petalOffset: CGFloat = -40.0
    @State private var isFirstDisplayed: Bool = false
    @State private var isPetalWidthMaxed: Bool = false
    @State private var isPetalOffsetMaxed: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
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
                .scaleEffect(0.75)
                .shadow(radius: 10)
                .overlay {
                    if isPetalWidthMaxed, isPetalOffsetMaxed {
                        Button {
                            withAnimation {
                                if !gestaltVM.clearedPrinciples.contains(Constants.Gestalt.PRAGNANZ) {
                                    gestaltVM.pragnanzPuzzleCleared = true
                                    gestaltVM.clearedPrinciples.append(Constants.Gestalt.PRAGNANZ)
                                }
                            }
                        } label: {
                            Text("🌺")
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
                }
                .overlay(alignment: .bottom) {
                    if isPetalWidthMaxed, isPetalOffsetMaxed {
                       Text("Because You recognize this whole figure\nas easy as possible!")
                           .bold()
                           .font(.title)
                           .multilineTextAlignment(.center)
                   } else if petalWidth > 80 || petalOffset > -40 {
                       Text("You know it is a Flower, right?")
                           .bold()
                           .font(.title)
                   } else if petalWidth > 40 || petalOffset > -40 { // 둘 중 하나가 움직이고 있을 때
                       Text("It has complecated figures but...")
                           .bold()
                           .font(.title)
                   } else if petalWidth <= 40 || petalOffset <= -40 { // 시작점
                        Text("Move the Knob to the end!")
                            .bold()
                            .font(.title)
                   }
                }
                
                Slider(value: $petalWidth, in: 40...100, onEditingChanged: { _ in
                    if petalWidth == 100 {
                        withAnimation(.linear(duration: 0.7)) {
                            isPetalWidthMaxed.toggle()
                        }
                    }
                })
                .disabled(petalWidth == 100)
                .padding()
                
                Slider(value: $petalOffset, in: -40...60, onEditingChanged: { _ in
                    if petalOffset == 60 {
                        withAnimation(.linear(duration: 0.7)) {
                            isPetalOffsetMaxed.toggle()
                        }
                    }
                })
                .disabled(petalOffset == 60)
                .padding()
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
                        Welcome to the Gestalt Principle of **Prägnanz**!
                        
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
        }
        
    }
}

struct PragnanzPreview: PreviewProvider {
    static var previews: some View {
        PragnanzView(gestaltVM: GestaltVM())
    }
}
