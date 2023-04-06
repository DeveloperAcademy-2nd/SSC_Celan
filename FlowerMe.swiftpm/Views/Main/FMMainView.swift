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
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                            .padding(24)
                    }
                } else {
                    NavigationLink {
                        TabView {
                            NavigationView {
                                FMFlowerMainView(flowerVM: flowerVM)
                                    .navigationBarTitleDisplayMode(.large)
                                    .navigationTitle("Flowers' Gestalt")
                            }
                            .tabItem {
                                Label("home", systemImage: "house")
                            }
                            .navigationViewStyle(.stack)
                            
                            NavigationView {
                                Text("Post")
                                    .navigationTitle("Post")
                            }
                            .tabItem {
                                Label("post", systemImage: "signpost.right")
                            }
                            .navigationViewStyle(.stack)
                        }
                        .navigationBarBackButtonHidden()
                    } label: {
                        FMCustomCardView(style: .mini()) {
                            Text("Pick a Flower for Yourself")
                                .frame(alignment: .center)
                        }
                    }
                }
            }
        }
        .tabViewStyle(.page)
    }
}

