//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/06.
//

import SwiftUI

final class GestaltVM: ObservableObject {
    @Published var clearedPrinciples = [String]()
    @Published var isFirstDisplayedDict: [String: Bool] = [:]
}
