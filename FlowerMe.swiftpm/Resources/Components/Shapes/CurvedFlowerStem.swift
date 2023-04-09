//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/09.
//

import SwiftUI

struct CurvedFlowerStem: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            
            path.addCurve(
                to: .init(x: rect.width, y: rect.height),
                control1: .init(x: 0, y: rect.height * 0.25),
                control2: .init(x: rect.width * 1.5, y: rect.height * 0.75)
            )
        }
    }
}

struct CurvedFlowerStemReversed: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: -(rect.width), y: rect.height))
            
            path.addCurve(
                to: .zero,
                control1: .init(x: -(rect.width * 1.5), y: rect.height * 0.75),
                control2: .init(x: 0, y: rect.height * 0.25)
            )
        }
    }
}

struct Moving: AnimatableModifier {
    var time: CGFloat
    let path: Path
    var start: CGPoint = .init(x: 0, y: 0)
    var isReversed: Bool = false
    
    var animatableData: CGFloat {
        get { time }
        set { time = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .position(
                path.trimmedPath(from: 0, to: time).currentPoint ?? start
            )
    }
}
