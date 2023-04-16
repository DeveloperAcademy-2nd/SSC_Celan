//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/14.
//

import SwiftUI

struct FivePetalsFlower: Shape {
    var petalOffset: CGFloat = -60
    var petalWidth: CGFloat = 150
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // 5 petals
        for number in stride(
            from: 0,
            to: Double.pi,
            by: Double.pi / 5
        ) {
            // rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(
                rotationAngle: number * 2
            )
            
            // move the petal to be at the center of our view
            let position = rotation.concatenating(
                CGAffineTransform(
                    translationX: rect.width / 2,
                    y: rect.height / 2
                )
            )
            
            // create a path for petal using our properties plus a fixed Y and height
            let originalPetal = Path(
                ellipseIn: CGRect(
                    x: petalOffset,
                    y: 0,
                    width: petalWidth,
                    height: rect.width / 4
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
