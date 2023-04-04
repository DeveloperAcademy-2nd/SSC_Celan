//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/04.
//

import SwiftUI

struct FMMainView: View {
    var body: some View {
        TabView {
            ForEach(Constants.INTRO_ONBOARDING, id: \.self) { text in
                FMCustomCardView(style: .large()) {
                    Text(text)
                        .font(.title2)
                }
            }
        }
        .tabViewStyle(.page)
    }
}
