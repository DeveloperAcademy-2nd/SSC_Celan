//
//  SwiftUIView 2.swift
//  
//
//  Created by Celan on 2023/04/06.
//

import SwiftUI

struct Petal: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            // Initial Point
            path.move(to: .zero)
            
            // 0,0 -> 200,0
            path.addLine(to: CGPoint(x: rect.width * 1.1, y: 0))
            
            // (200, 0) -> (200, 200*0.2125)
            path.addLine(to: CGPoint(
                x: rect.width * 1.2,
                y: rect.height * 0.4515)
            )
            
            // First Bezier Curve
            path.addCurve(
                to: CGPoint(x: 0, y: rect.height * 0.4215),
                control1: CGPoint(
                    x: rect.width - 60,
                    y: rect.height * 0.01
                ),
                control2: CGPoint(
                    x: rect.width * 3/5,
                    y: rect.height * 0.09375
                )
            )
            
            // Second Bezier Curve
            path.addCurve(
                to: CGPoint(x: 0, y: 0),
                control1: CGPoint(x: 0, y: 75),
                control2: CGPoint(x: 75, y: 75)
            )
            
            // To 0,0
            path.addLine(to: .zero)
//            path.closeSubpath()
        }
    }
}
