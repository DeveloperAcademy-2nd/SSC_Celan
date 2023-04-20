//
//  PreviewView.swift
//  FlowerMe
//
//  Created by Celan on 2023/04/05.
//

import SwiftUI

struct PreviewView: View {
    var body: some View {
        TabView {
            FMCustomCardView(style: .mini()) {
                Text("Mini")
            }
            
            FMCustomCardView(style: .normal()) {
                Text("Normal")
            }
            
            FMCustomCardView(style: .large()) {
                Text("Large")
            }
        }
        .tabViewStyle(.page)
    }
}
