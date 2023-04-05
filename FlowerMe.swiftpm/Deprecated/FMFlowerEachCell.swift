//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/04.
//

import SwiftUI

struct FMFlowerEachCell: View {
    @ObservedObject var flowerVM: FlowerVM
    @Binding var isDetailCardViewDisplayed: Bool
    let flower: Flower
    
    var body: some View {
            Button {
                withAnimation {
                    flowerVM.currentFlower = flower
                    isDetailCardViewDisplayed.toggle()
                }
            } label: {
                LazyVStack(
                    alignment: .leading,
                    pinnedViews: .sectionHeaders
                ) {
                    Section {
                        Text(flower.footer)
                    } header: {
                        BuildFlowerSectionHeader(with: flower)
                    }
                    
                    Divider()
                }
                .foregroundColor(.primary)
            }
    }
    
    /**
     Flower View의 Section Header를 생성합니다.
     */
    private func BuildFlowerSectionHeader(with flower: Flower) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(flower.name)
                    .bold()
                    .font(.title2)
                
                Text(flower.languageOfFlowers)
            }
            
            
            Spacer()
            // 이 꽃으로 보냈던 편지의 갯수를 보여주면 어때
            HStack(spacing: 10) {
                // if sentPostCount != 0 {
                Image(systemName: "paperplane.fill")
                // } else {
                // Image(systemName: "paperplane")
                // }
                Text("\(0)")
                
            }
            
        }
        .padding(.vertical, 24)
        .frame(alignment: .leading)
        .background {
            LinearGradient(
                colors: [
                    Color(.systemBackground),
                    Color(.systemBackground),
                    Color(.systemBackground),
                    Color(.systemBackground),
                    Color(.systemBackground),
                    Color(.systemBackground),
                    Color(.systemBackground).opacity(0.7),
                    Color(.systemBackground).opacity(0.4),
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

