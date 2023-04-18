//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/06.
//

import SwiftUI

struct HalfFlowerView: View {
    @ObservedObject var gestaltVM: GestaltVM
    @Binding var topLeadingPetal: Double
    @Binding var bottomLeadingLeaf: Double
    
    var body: some View {
        VStack(spacing: Constants.ClosureFlowerCGFloat.CLOSURE_WIDTH / 6) {
            Petal()
                .fill(
                    gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE) || gestaltVM.isClosurePuzzleDone
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
                .frame(
                    width: Constants.ClosureFlowerCGFloat.CLOSURE_WIDTH,
                    height: Constants.ClosureFlowerCGFloat.CLOSURE_HEIGHT
                )
            // 270
                .rotationEffect(
                    .degrees(
                        gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE)
                        ? 270
                        : topLeadingPetal
                    )
                )
                .onTapGesture {
                    if Int(topLeadingPetal) % 270 != 0 {
                        withAnimation {
                            topLeadingPetal += 45.0
                            if Int(topLeadingPetal) % 270 == 0 {
                                gestaltVM.closurePuzzle.append(true)
                            }
                        }
                    }
                }
            
            Leaf()
                .fill(
                    gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE) || gestaltVM.isClosurePuzzleDone
                    ? LinearGradient(
                        gradient: Gradient(
                            colors: [
                                Color(red: 117/255, green: 211/255, blue: 76/255),
                                Color(red: 38/255, green: 164/255, blue: 27/255)
                            ]
                        ),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    : LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black
                        ]),
                        startPoint: .top,
                        endPoint: .top
                    )
                )
                .frame(
                    width: Constants.ClosureFlowerCGFloat.CLOSURE_WIDTH / 2,
                    height: Constants.ClosureFlowerCGFloat.CLOSURE_HEIGHT / 2
                )
            // 180
                .rotationEffect(
                    .degrees(
                        gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE)
                        ? 180
                        : bottomLeadingLeaf
                    )
                )
                .rotation3DEffect(
                    .degrees(180),
                    axis: (x: -1, y: 1, z: 0)
                )
                .onTapGesture {
                    if Int(bottomLeadingLeaf) % 180 != 0 {
                        withAnimation {
                            bottomLeadingLeaf += 36.0
                            if Int(bottomLeadingLeaf) % 180 == 0 {
                                gestaltVM.closurePuzzle.append(true)
                            }
                        }
                    }
                }
        }
    }
}

struct HalfFlowerReversedView: View {
    @ObservedObject var gestaltVM: GestaltVM
    @Binding var topTrailingPetal: Double
    @Binding var bottomTrailingLeaf: Double
    
    var body: some View {
        VStack(spacing: Constants.ClosureFlowerCGFloat.CLOSURE_WIDTH / 6) {
            Petal()
                .fill(
                    gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE) || gestaltVM.isClosurePuzzleDone
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
                .frame(
                    width: Constants.ClosureFlowerCGFloat.CLOSURE_WIDTH,
                    height: Constants.ClosureFlowerCGFloat.CLOSURE_HEIGHT
                )
            // 270
                .rotationEffect(
                    .degrees(
                        gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE)
                        ? 270
                        : topTrailingPetal
                    )
                )
                .onTapGesture {
                    if Int(topTrailingPetal) % 270 != 0 || topTrailingPetal == 0 {
                        withAnimation {
                            topTrailingPetal += 135.0
                            if Int(topTrailingPetal) % 270 == 0 {
                                gestaltVM.closurePuzzle.append(true)
                            }
                        }
                    }
                }
            
            Leaf()
                .fill(
                    gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE) || gestaltVM.isClosurePuzzleDone
                    ? LinearGradient(
                        gradient: Gradient(
                            colors: [
                                Color(red: 117/255, green: 211/255, blue: 76/255),
                                Color(red: 38/255, green: 164/255, blue: 27/255)
                            ]
                        ),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    : LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black
                        ]),
                        startPoint: .top,
                        endPoint: .top
                    )
                )
                .frame(
                    width: Constants.ClosureFlowerCGFloat.CLOSURE_WIDTH / 2,
                    height: Constants.ClosureFlowerCGFloat.CLOSURE_HEIGHT / 2
                )
            // 180
                .rotationEffect(
                    .degrees(
                        gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE)
                        ? 180
                        : bottomTrailingLeaf
                    )
                )
                .rotation3DEffect(
                    .degrees(180),
                    axis: (x: -1, y: 1, z: 0)
                )
                .onTapGesture {
                    if Int(bottomTrailingLeaf) % 180 != 0 || bottomTrailingLeaf == 0 {
                        withAnimation {
                            bottomTrailingLeaf += 60.0
                            if Int(bottomTrailingLeaf) % 180 == 0, bottomTrailingLeaf != 0 {
                                gestaltVM.closurePuzzle.append(true)
                            }
                        }
                    }
                }
        }
        .rotation3DEffect(
            .degrees(180),
            axis: (x: 0, y: 1, z: 0)
        )
    }
}

struct Leaf: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            
            // 0,0 -> 300,0
            path.addLine(
                to: CGPoint(
                    x: rect.width,
                    y: rect.height * 0.4515
                )
            )
            
            path.addCurve(
                to: CGPoint(x: -80, y: -rect.height * 0.55),
                control1: CGPoint(x: rect.minX, y: rect.minY+30),
                control2: CGPoint(x: rect.minX+10, y: rect.maxY)
            )
            
            path.addCurve(
                to: CGPoint(x: 0, y: 70),
                control1: CGPoint(x: 0, y: 0),
                control2: CGPoint(x: 0, y: 0)
            )
        }
    }
}

struct ClosurePreview2: PreviewProvider {
    static var previews: some View {
        ClosureView(gestaltVM: GestaltVM())
            .previewInterfaceOrientation(.landscapeRight)
    }
}
