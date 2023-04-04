//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/04.
//

import SwiftUI

struct FMFlowerMainView: View {
    @ObservedObject var flowerVM: FlowerVM
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(flowerVM.flowerList, id: \.id) { flower in
                LazyVStack(
                    alignment: .leading,
                    pinnedViews: .sectionHeaders
                ) {
                    Section {
                        ForEach(flower.bloomingSeason, id: \.self) { season in
                            Text(season)
                        }
                    } header: {
                        HStack {
                            Text(flower.name)
                                .font(.largeTitle)
                            Spacer()
                            // 이 꽃으로 보냈던 편지의 갯수를 보여주면 어때
                            Text("posts: \(0)")
                        }
                        .padding(.vertical, 24)
                        .frame(alignment: .leading)
                        .background {
                            LinearGradient(
                                colors: [
                                    Color(.systemBackground),
                                    Color(.systemBackground).opacity(0.4),
                                    Color(.systemBackground).opacity(0.1),
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 32)
    }
}
