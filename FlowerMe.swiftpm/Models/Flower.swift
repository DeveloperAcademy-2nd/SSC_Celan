//
//  File.swift
//  
//
//  Created by Celan on 2023/04/04.
//

import SwiftUI

struct Flower: Hashable {
    var id: String = UUID().uuidString
    var name: String
    var bloomingSeason: [String]
    var languageOfFlowers: String
    var footer: String
    var image: String
    
    var tintColor: Color {
        // TODO: 색 구체화하기
        if bloomingSeason.contains(Constants.FlowerSeasons.SPRING) {
            return .yellow
        } else if bloomingSeason.contains(Constants.FlowerSeasons.SUMMER) {
            return .orange
        } else if bloomingSeason.contains(Constants.FlowerSeasons.FALL) {
            return .brown
        } else if bloomingSeason.contains(Constants.FlowerSeasons.WINTER) {
            return .white
        }
        
        return .black
    }
    
    init(
        name: String,
        languageOfFlowers: String,
        footer: String,
        image: String,
        bloomingSeason: String...
    ) {
        self.name = name
        self.bloomingSeason = bloomingSeason
        self.languageOfFlowers = languageOfFlowers
        self.footer = footer
        self.image = image
    }
}


