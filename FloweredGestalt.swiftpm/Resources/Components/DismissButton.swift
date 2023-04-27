//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/19.
//

import SwiftUI

struct DismissButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Text("Go back to Main")
                .bold()
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
        }
        .buttonStyle(.borderedProminent)
        .padding()
    }
}
