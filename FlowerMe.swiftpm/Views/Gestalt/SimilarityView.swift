//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/05.
//

import SwiftUI

struct SimilarityView: View {
    let gridItem: [GridItem] = Array(
        repeating: .init(
            .flexible(),
            spacing: 10
        ),
        count: 8
    )
    
    var body: some View {
        LazyVGrid(columns: gridItem) {
            ForEach(0..<88) { index in
                MiniFlower(
                    tintColor: index >= 48 ? Color("SpringTint") : Color("SummerTint"),
                    budColor: index >= 48 ? Color.white : Color.yellow,
                    radian: index >= 48 ? 2 : 15
                )
            }
        }
    }
}

struct SimilaryityPreview: PreviewProvider {
    static var previews: some View {
        SimilarityView()
    }
}
