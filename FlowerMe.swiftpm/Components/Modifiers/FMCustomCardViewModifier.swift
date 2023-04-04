//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/04.
//

import SwiftUI

struct FMCustomCardViewModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    let horizontalPadding: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: horizontalPadding)
            .padding(25)
            .background(
                RoundedRectangle(cornerRadius: 17, style: .continuous)
                    .fill(
                        colorScheme == .dark
                        ? Color(.systemGray2)
                        : Color.white
                    )
                    .frame(minHeight: horizontalPadding * 1.618)
                    .shadow(
                        color: Color(.systemGray2)
                            .opacity(
                                colorScheme == .dark
                                ? 0.0
                                : 0.3
                            ),
                        radius: 10,
                        x: 8,
                        y: 5
                    )
            )
    }
}

extension View {
    public func fmCustomCardViewModify(horizontalPadding: CGFloat) -> some View {
        modifier(FMCustomCardViewModifier(horizontalPadding: horizontalPadding))
    }
}
