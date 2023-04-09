//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/05.
//

import SwiftUI

struct ContinuationView: View {
    @ObservedObject var gestaltVM: GestaltVM
    @State private var timeMax: CGFloat = 0.0
    @State private var isFirstDisplayed: Bool = false
    
    var body: some View {
        ZStack {
            HStack {
                CurvedFlowerStem()
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 4,
                            dash: [10]
                        )
                    )
                    .foregroundColor(.gray)
                    .frame(
                        width: UIScreen.main.bounds.width / 5,
                        height: UIScreen.main.bounds.width / 5 * 4
                    )
//                    .overlay {
//                        Circle()
//                            .foregroundColor(.gray)
//                            .frame(width: 30)
//                            .modifier(Moving(time: timeMax, path: gestaltVM.path))
//                            .animation(.easeInOut(duration: gestaltVM.duration), value: timeMax)
//                    }
//                    .overlay(alignment: .bottomTrailing) {
//                        // 좌상단 꽃
//                        Text("좌하단 뿌리")
//                            .foregroundColor(.red)
//                    }
                
                CurvedFlowerStemReversed()
                    .stroke(
                        style:
                            StrokeStyle(
                                lineWidth: 4,
                                lineJoin: .round
                            )
                    )
                    .frame(
                        width: UIScreen.main.bounds.width / 5,
                        height: UIScreen.main.bounds.width / 5 * 4
                    )
                    .overlay {
                        Circle()
                            .frame(width: 30)
                            .gesture(
                                DragGesture(minimumDistance: 0.0)
                                    .onChanged { newValue in
                                        if newValue.startLocation.y.isLessThanOrEqualTo(newValue.location.y), timeMax < 1.0 {

                                        } else if newValue.location.y.isLessThanOrEqualTo(newValue.startLocation.y), timeMax < 1.0 {
                                            timeMax += -(newValue.translation.height / 50_000)
                                        }
                                    }
                            )
                            .modifier(Moving(time: timeMax, path: gestaltVM.pathReversed, start: gestaltVM.startReversed))
                            .animation(.easeInOut(duration: gestaltVM.duration), value: timeMax)
                    }
                    .overlay(alignment: .topLeading) {
                        Text("우상단 꽃")
                    }
            }
            
            if gestaltVM.continuityPuzzleCleared {
                Text("💐")
                    .font(.title2)
                    .modifier(ParticlesModifier())
                    .frame(
                        maxHeight: .infinity
                    )
                
                Text("💐")
                    .font(.title2)
                    .modifier(ParticlesModifier())
                    .frame(
                        maxHeight: .infinity
                    )
            }
            
        }
        .onAppear {
            if !gestaltVM.isFirstDisplayedContinuity {
                isFirstDisplayed.toggle()
            } else if gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CONTINUITY) {
                timeMax = 1.0
            }
        }
        .onChange(of: timeMax, perform: { newValue in
            if timeMax > 1.0, !gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CONTINUITY) {
                gestaltVM.continuityPuzzleCleared = true
            }
        })
        .show(isActivated: $isFirstDisplayed) {
            FMCustomCardView(style: .large()) {
                VStack {
                    Text(
                        """
                        Welcome to the Gestalt Principle of **Continuity**!
                        내용 바꾸는 상상
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
                        gestaltVM.isFirstDisplayedContinuity = true
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
        .show(isActivated: $gestaltVM.continuityPuzzleCleared) {
            FMCustomCardView(style: .large()) {
                VStack {
                    Text(
                        """
                        Conguratulations!
                        
                        You have cleared The Gestalt Principle of **Continuity**!
                        
                        내용바꾸기
                        
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
                    gestaltVM.clearedPrinciples.append(Constants.Gestalt.CONTINUITY)
                }
            }
            .overlay(alignment: .bottom) {
                    Button {
                        withAnimation {
                            gestaltVM.continuityPuzzleCleared.toggle()
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

struct Preview_Continuation: PreviewProvider {
    static var previews: some View {
        ContinuationView(gestaltVM: GestaltVM())
    }
}
