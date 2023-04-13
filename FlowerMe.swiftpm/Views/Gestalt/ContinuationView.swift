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
                    .overlay {
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 30)
                            .modifier(Moving(time: timeMax, path: gestaltVM.path))
                            .animation(.easeInOut(duration: gestaltVM.duration), value: timeMax)
                    }
                
                // Solid
                CurvedFlowerStemReversed()
                    .stroke(
                        style:
                            StrokeStyle(
                                lineWidth: 4,
                                lineJoin: .round
                            )
                    )
                    .foregroundColor(
                        timeMax < 0.4
                        ? .primary
                        : .green
                    )
                    .frame(
                        width: UIScreen.main.bounds.width / 5,
                        height: UIScreen.main.bounds.width / 5 * 4
                    )
                    .overlay {
                        // TODO: - 나중에 timeMax 일 때, 탭해서 카드 띄우도록
                        if timeMax > 1.0 || gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CONTINUITY) {
                            Button {
                                withAnimation {
                                    if !gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CONTINUITY) {
                                        gestaltVM.continuityPuzzleCleared = true
                                    }
                                }
                            } label: {
                                Circle()
                                    .fill(Color.yellow)
                                    .padding()
                                    .frame(
                                        maxWidth: UIScreen.main.bounds.width / 16,
                                        maxHeight: UIScreen.main.bounds.height / 16
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
                            .position(.zero)
                        } else {
                            Circle()
                                .frame(width: 30)
                                .foregroundColor(
                                    timeMax < 0.4
                                    ? .primary
                                    : .yellow
                                )
                                .gesture(
                                    DragGesture(minimumDistance: 0.0)
                                        .onChanged { newValue in
                                            if newValue.startLocation.y.isLessThanOrEqualTo(newValue.location.y), timeMax < 1.0 {
                                                
                                            } else if newValue.location.y.isLessThanOrEqualTo(newValue.startLocation.y), timeMax < 1.0 {
                                                withAnimation {
                                                    timeMax += -(newValue.translation.height / 45_000)
                                                }
                                            }
                                        }
                                )
                                .modifier(Moving(time: timeMax, path: gestaltVM.pathReversed, start: gestaltVM.startReversed))
                                .animation(.easeInOut(duration: gestaltVM.duration), value: timeMax)
                        }
                    }
                    .background {
                        TransformableFlower(
                            petalOffset: timeMax * 20,
                            petalWidth: timeMax * 30
                        )
                        .fill(
                            LinearGradient(
                                colors: [
                                    .red,
                                    .red,
                                    .white
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .position(.zero)
                    }
                    .overlay {
                        if timeMax < 0.15 {
                            Text("Drag This Circle")
                                .bold()
                                .position(
                                    x: -(UIScreen.main.bounds.width / 5 * 1.6),
                                    y: UIScreen.main.bounds.width / 5 * 4
                                )
                            
                            Text("To Here!")
                                .bold()
                                .position(
                                    x: UIScreen.main.bounds.width / 7,
                                    y: .zero
                                )
                        }
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
        .show(isActivated: $isFirstDisplayed) {
            FMCustomCardView(style: .large()) {
                VStack {
                    Text(
                        """
                        Welcome to the Gestalt Principle of **Continuity**!
                        
                        Here, You can drag a circle at the bottom
                        of the solid curve.
                        When You drag it to the top,
                        you can bloom a nice Rose.
                        But wait, there is another dashed line!
                        
                        Is that dashed line the same group with solid line?
                        Let's find out!
                        Drag a Circle and bloom Your Rose!
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
                        
                        The Gestalt Principle of Continuity states that
                        objects will be grouped as a whole
                        if they are co-linear, or follow a direction.
                        
                        As you pressed a Circle, drag and follow the line,
                        you finally bloom a Rose!
                        
                        And this is a **Rose** badge for You!
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
