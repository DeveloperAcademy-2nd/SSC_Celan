//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/10.
//

import SwiftUI

struct MiniFlower: View {
    let tintColor: Color
    let budColor: Color
    let radian: CGFloat
    
    var body: some View {
        ZStack {
            MiniPetal()
                .rotationEffect(
                    .radians(radian * 5)
                )
            
            MiniPetal()
                .rotationEffect(
                    .radians(radian * 2)
                )
            
            MiniPetal()
                .rotationEffect(
                    .radians(radian * 3)
                )
            
            MiniPetal()
                .rotationEffect(
                    .radians(radian * 4)
                )
            
            MiniPetal()
                .rotationEffect(
                    .radians(radian)
                )
            
            Circle()
                .fill(budColor)
                .frame(width: 20, height: 20)
                .shadow(radius: 15)
        }
        
        
    }
    
    private func MiniPetal() -> some View {
        Ellipse()
            .fill(tintColor)
            .frame(
                width: 25,
                height: 60
            )
    }
}
