//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/04.
//

import SwiftUI

struct FMShowCustomAlert<CustomAlert: View>: ViewModifier {
    var isActiveted: Binding<Bool>
    var label: CustomAlert
    
    init(
        isActiveted: Binding<Bool>,
        label: () -> CustomAlert
    ) {
        self.isActiveted = isActiveted
        self.label = label()
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            ZStack {
                if isActiveted.wrappedValue {
                    Color(.systemGray2)
                        .opacity(0.4)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity
                        )
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isActiveted.wrappedValue.toggle()
                            }
                        }
                    
                    label
                }
            }
        }
    }
}

extension View {
    func show(
        isActivated: Binding<Bool>,
        @ViewBuilder label: () -> some View
    ) -> some View {
        modifier(
            FMShowCustomAlert(
                isActiveted: isActivated,
                label: label
            )
        )
    }
}
