//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/04.
//

import SwiftUI

struct FMMainView: View {
    @ObservedObject var flowerVM: FlowerVM = FlowerVM()
    @State private var isNavigated: Bool = false
    
    var body: some View {
        TabView {
            ForEach(Constants.INTRO_ONBOARDING, id: \.self) { text in
                if text != "" {
                    FMCustomCardView(style: .large()) {
                        Text(text)
                            .font(.title2)
                    }
                } else {
                    NavigationLink {
                        TabView {
                            FMFlowerMainView(flowerVM: flowerVM)
                                .navigationBarBackButtonHidden()
                                .tabItem {
                                    Label("home", systemImage: "house")
                                }
                            
                            Text("편지통")
                                .tabItem {
                                    Label("post", systemImage: "signpost.right")
                                }
                        }
                        
                    } label: {
                        FMCustomCardView(style: .mini()) {
                            Text("Pick a Flower for Yourself")
                        }
                    }
                }
            }
        }
        .tabViewStyle(.page)
    }
}

