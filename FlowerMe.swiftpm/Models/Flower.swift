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
    
    var tintColors: [Color] {
        var colors = [Color]()
        // TODO: 색 구체화하기
        for season in bloomingSeason {
            switch season {
            case Constants.FlowerSeasons.SPRING,
                Constants.FlowerSeasons.SUMMER,
                Constants.FlowerSeasons.FALL,
                Constants.FlowerSeasons.WINTER:
                colors.append(Color("\(season)Tint"))
            default:
                break
            }
        }
        
        return colors
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


