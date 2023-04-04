//
//  File.swift
//  
//
//  Created by Celan on 2023/04/04.
//

import SwiftUI

final class FlowerVM: ObservableObject {
    @Published var flowerList: [Flower] = [
        .init(
            name: "Red Rose",
            languageOfFlowers: "I Love You",
            footer: "The madness of love the greatest of heaven’s blessings.",
            image: "rose",
            bloomingSeason: Constants.FlowerSeasons.SPRING, Constants.FlowerSeasons.SUMMER, Constants.FlowerSeasons.FALL
        ),
        .init(
            name: "Basil",
            languageOfFlowers: "Wishes Good Luck",
            footer: "Chance favors the prepared mind.",
            image: "basil",
            bloomingSeason: Constants.FlowerSeasons.SUMMER
        ),
        .init(
            name: "Dianthus",
            languageOfFlowers: "Be Gallant",
            footer: "He who is brave is free.",
            image: "dianthus",
            bloomingSeason: Constants.FlowerSeasons.SPRING, Constants.FlowerSeasons.SUMMER
        ),
    ]
}
