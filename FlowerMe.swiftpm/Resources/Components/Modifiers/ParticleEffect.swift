//
//  ParticleEffect.swift
//  partTest
//
//  Created by Celan on 2023/03/29.
//

import SwiftUI

struct ParticlesModifier: ViewModifier {
    @State var time = 0.0
    @State var scale = 0.1
    let duration = 5.0
    let numberOfParticles: Int?
    
    init(
        time: Double = 0.0,
        scale: Double = 0.1,
        numberOfParticles: Int? = 80
    ) {
        self.time = time
        self.scale = scale
        self.numberOfParticles = numberOfParticles
    }
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<numberOfParticles!, id: \.self) { index in
                content
                    .modifier(FireworkParticlesGeometryEffect(time: time))
                    .opacity(((duration-time) / duration))
            }
        }
        .onAppear {
            withAnimation (.easeOut(duration: duration)) {
                self.time = duration
                self.scale = 1.0
            }
        }
    }
}

struct FireworkParticlesGeometryEffect: GeometryEffect {
    var time: Double
    var speed = Double.random(in: 20 ... 200)
    var direction = Double.random(in: -Double.pi ...  Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation = CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}
