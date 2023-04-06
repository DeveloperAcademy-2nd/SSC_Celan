//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/06.
//

import SwiftUI

struct HalfFlowerView: View {
    @Binding var topLeadingPetal: Double
    @Binding var bottomLeadingLeaf: Double
    
    var body: some View {
        VStack(spacing: 100) {
            Petal()
                .frame(width: 400, height: 400)
            // 270
                .rotationEffect(.degrees(topLeadingPetal))
                .onTapGesture {
                    if Int(topLeadingPetal) % 270 != 0 {
                        withAnimation {
                            topLeadingPetal += 45.0
                        }
                    }
                }
            
            Leaf()
                .frame(width: 200, height: 200)
            // 180
                .rotationEffect(.degrees(bottomLeadingLeaf))
                .rotation3DEffect(
                    .degrees(180),
                    axis: (x: -1, y: 1, z: 0)
                )
                .onTapGesture {
                    if Int(bottomLeadingLeaf) % 180 != 0 {
                        withAnimation {
                            bottomLeadingLeaf += 36.0
                        }
                    }
                }
        }
    }
}

struct HalfFlowerReversedView: View {
    @Binding var topTrailingPetal: Double
    @Binding var bottomTrailingLeaf: Double
    
    var body: some View {
        VStack(spacing: 100) {
            Petal()
                .frame(width: 400, height: 400)
            // 270
                .rotationEffect(.degrees(topTrailingPetal))
                .onTapGesture {
                    if Int(topTrailingPetal) % 270 != 0 || topTrailingPetal == 0 {
                        withAnimation {
                            topTrailingPetal += 135.0
                        }
                    }
                }
            
            Leaf()
                .frame(width: 200, height: 200)
            // 180
                .rotationEffect(.degrees(bottomTrailingLeaf))
                .rotation3DEffect(
                    .degrees(180),
                    axis: (x: -1, y: 1, z: 0)
                )
                .onTapGesture {
                    if Int(bottomTrailingLeaf) % 180 != 0 || bottomTrailingLeaf == 0 {
                        withAnimation {
                            bottomTrailingLeaf += 60.0
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
