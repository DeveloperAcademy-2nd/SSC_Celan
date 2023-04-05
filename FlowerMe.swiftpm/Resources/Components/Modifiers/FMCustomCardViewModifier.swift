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
    let verticalPadding: CGFloat?
    
    func body(content: Content) -> some View {
        // Background Card
        RoundedRectangle(
            cornerRadius: 18
//            style: .continuous
        )
        .fill(
            colorScheme == .dark
            ? Color(.systemGray2)
            : Color.white
        )
        .frame(
            width: horizontalPadding,
            height: verticalPadding != nil ? verticalPadding : horizontalPadding * 1.618
        )
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
        .overlay {
            content
        }
    }
}

extension View {
    public func fmCustomCardViewModify(
        horizontalPadding: CGFloat,
        verticalPadding: CGFloat? = nil
    ) -> some View {
        modifier(
            FMCustomCardViewModifier(
                horizontalPadding: horizontalPadding,
                verticalPadding: verticalPadding ?? nil
            )
        )
    }
}
