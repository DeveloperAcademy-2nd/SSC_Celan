//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/12.
//

import SwiftUI

struct TransformableFlower: Shape {
    var petalOffset: CGFloat = -20
    var petalWidth: CGFloat = 100
    
    init(
        petalOffset: CGFloat,
        petalWidth: CGFloat
    ) {
        self.petalOffset = petalOffset
        self.petalWidth = petalWidth
    }
    
    func path(in rect: CGRect) -> Path {
        // The path that will hold all petals
        var path = Path()
        
        // Count from 0 up to pi * 2,
        // moving up pi / 6 each time
        for number in stride(
            from: 0,
            to: Double.pi * 2,
            by: Double.pi / 6
        ) {
            // rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(
                rotationAngle: number
            )
            
            // move the petal to be at the center of our view
            let position = rotation.concatenating(
                CGAffineTransform(
                    translationX: rect.width / 2,
                    y: rect.height / 2
                )
            )
            
            // create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(
                ellipseIn: CGRect(
                    x: petalOffset,
                    y: 0,
                    width: petalWidth,
                    height: rect.width / 2
                )
            )
            
            // apply our rotation/position transformation to the petal
            let rotatedPetal = originalPetal.applying(position)
            
            // add it to our main path
            path.addPath(rotatedPetal)
        }
        
        // now send the main path back
        return path
    }
}
