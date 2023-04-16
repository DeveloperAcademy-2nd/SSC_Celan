//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/04.
//

import SwiftUI

struct FMMainView: View {
    @ObservedObject var flowerVM: FlowerVM = FlowerVM()
    @ObservedObject var gestaltVM: GestaltVM = GestaltVM()
    @State private var isNavigated: Bool = false
    @State private var selection: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(0..<Constants.INTRO_ONBOARDING.count, id: \.self) { index in
                if Constants.INTRO_ONBOARDING[index] != "" {
                    FMCustomCardView(style: .large()) {
                        VStack(alignment: .trailing) {
                            Text(Constants.INTRO_ONBOARDING[index])
                                .font(.title2)
                                .frame(
                                    alignment: .leading
                                )
                                .padding()
                                .padding()
                        }
                    }
                    .overlay(alignment: .bottom) {
                        HStack {
                            if index > 0 {
                                Button {
                                    withAnimation {
                                        selection -= 1
                                    }
                                } label: {
                                    Text("Back")
                                        .bold()
                                        .foregroundColor(.primary)
                                        .padding(24)
                                        .padding(.horizontal, 24)
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.red)
                                .opacity(0.8)
                            }
                            
                            Button {
                                withAnimation {
                                    selection += 1
                                }
                            } label: {
                                Text("Next")
                                    .bold()
                                    .foregroundColor(.primary)
                                    .padding(24)
                                    .padding(.horizontal, 24)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding(.bottom, 24)
                    }
                    .tag(index)
                } else {
                    BuildNavigationLinkToMainView()
                    .tag(index)
                }
            }
        }
        .tabViewStyle(.page)
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }
    
    private func BuildNavigationLinkToMainView() -> some View {
        NavigationLink {
            TabView {
                NavigationView {
                    FMFlowerMainView(flowerVM: flowerVM, gestaltVM: gestaltVM)
                        .navigationBarTitleDisplayMode(.large)
                        .navigationTitle("Flowers' Gestalt")
                }
                .tabItem {
                    Label("home", systemImage: "house")
                }
                .navigationViewStyle(.stack)
                
                NavigationView {
                    MainBadgesView(flowerVM: flowerVM, gestaltVM: gestaltVM)
                        .navigationTitle("Badges")
                }
                .tabItem {
                    Label("Badges", systemImage: "star.circle")
                }
                .badge(gestaltVM.dispalyBadgesCount)
                .navigationViewStyle(.stack)
            }
            .navigationBarBackButtonHidden()
        } label: {
            FMCustomCardView(style: .large()) {
                Text("Enter!")
                    .font(.largeTitle)
                    .frame(alignment: .center)
            }
        }
    }
}

