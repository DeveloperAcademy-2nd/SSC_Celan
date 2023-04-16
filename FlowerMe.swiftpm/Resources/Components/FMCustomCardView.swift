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
            case let .mini(horizontalPadding, verticalPadding):
                content
                    .fmCustomCardViewModify(
                        horizontalPadding: horizontalPadding ?? UIScreen.main.bounds.width / 4,
                        verticalPadding: verticalPadding
                    )
            case let .normal(horizontalPadding, verticalPadding):
                content
                    .fmCustomCardViewModify(
                        horizontalPadding: horizontalPadding ?? UIScreen.main.bounds.width / 2.5,
                        verticalPadding: verticalPadding
                    )
            case let .large(horizontalPadding, verticalPadding):
                content
                    .fmCustomCardViewModify(
                        horizontalPadding: horizontalPadding ?? UIScreen.main.bounds.width / 1.5,
                        verticalPadding: verticalPadding
                    )
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
    case mini(horizontalPadding: CGFloat? = nil, verticalPadding: CGFloat? = nil)
    case normal(horizontalPadding: CGFloat? = nil, verticalPadding: CGFloat? = nil)
    case large(horizontalPadding: CGFloat? = nil, verticalPadding: CGFloat? = nil)
}


struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
}
