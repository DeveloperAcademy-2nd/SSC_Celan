//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/07.
//

import SwiftUI

struct MainBadgesView: View {
    @ObservedObject var flowerVM: FlowerVM
    @ObservedObject var gestaltVM: GestaltVM
    @State private var isDetailCardViewDisplayed: Bool = false
    let gridSystem: [GridItem] = [
        .init(.flexible(), spacing: 25),
        .init(.flexible(), spacing: 25),
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: gridSystem) {
                ForEach(gestaltVM.clearedPrinciples, id: \.self) { text in
                    Text(text)
                    .padding(.bottom, 25)
                }
            }
            .padding(.top, 32)
        }
        .onAppear {
            gestaltVM.dispalyBadgesCount = 0
        }
    }
}
