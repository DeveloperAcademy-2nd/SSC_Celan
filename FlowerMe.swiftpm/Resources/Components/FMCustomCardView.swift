//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/04.
//

import SwiftUI

struct FMCustomCardView<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    let content: Content
    let style: CardViewStyle?
    
    var body: some View {
        if let style {
            switch style {
            case let .mini(horizontalPadding):
                VStack {
                    content
                        .fmCustomCardViewModify(horizontalPadding: horizontalPadding ?? 150)
                }
            case let .normal(horizontalPadding):
                VStack {
                    content
                        .fmCustomCardViewModify(horizontalPadding: horizontalPadding ?? 350)
                }
            case let .large(horizontalPadding):
                VStack {
                    content
                        .fmCustomCardViewModify(horizontalPadding: horizontalPadding ?? 525)
                }
            }
        }
    }
    
    init(
        style: CardViewStyle = .normal(),
        @ViewBuilder label: () -> Content
    ) {
        self.style = style
        self.content = label()
    }
}

enum CardViewStyle {
    case mini(horizontalPadding: CGFloat? = nil)
    case normal(horizontalPadding: CGFloat? = nil)
    case large(horizontalPadding: CGFloat? = nil)
}
