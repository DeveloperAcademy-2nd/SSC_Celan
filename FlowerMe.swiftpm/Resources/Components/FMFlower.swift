//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/12.
//

import SwiftUI

struct FMFlower: View {
    var body: some View {
        ZStack {
            Group {
                FlowerPetal()
                    .rotationEffect(.degrees(150))
                FlowerPetal()
                    .rotationEffect(.degrees(170))
                FlowerPetal()
                    .rotationEffect(.degrees(190))
                FlowerPetal()
                    .rotationEffect(.degrees(130))
                FlowerPetal()
                    .rotationEffect(.degrees(110))
                FlowerPetal()
                    .rotationEffect(.degrees(100))
                FlowerPetal()
                    .rotationEffect(.degrees(70))
                FlowerPetal()
                    .rotationEffect(.degrees(50))
                FlowerPetal()
                    .rotationEffect(.degrees(30))
            }
           
           
            FlowerPetal()
                .rotationEffect(.degrees(210))
            FlowerPetal()
                .rotationEffect(.degrees(240))
            FlowerPetal()
                .rotationEffect(.degrees(250))
            FlowerPetal()
                .rotationEffect(.degrees(280))
            FlowerPetal()
                .rotationEffect(.degrees(290))
            FlowerPetal()
                .rotationEffect(.degrees(310))
            FlowerPetal()
                .rotationEffect(.degrees(330))
            FlowerPetal()
                .rotationEffect(.degrees(360))
            
            Circle()
                .fill(Color.yellow)
                .frame(width: 90)
                .shadow(radius: 10)
        }
    }
}

struct FlowerPetal: View {
    var body: some View {
        Ellipse()
            .trim(from: 0.25, to: 0.75)
            .fill(.red)
            .frame(
                width: 200,
                height: 60
            )
           
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FMFlower()
    }
}
