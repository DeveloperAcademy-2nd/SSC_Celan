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
            ForEach(
                Constants.INTRO_ONBOARDING,
                id: \.self
            ) { text in
                FMCustomCardView {
                    Text(text)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .tabViewStyle(.page)
    }
}

struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
}
