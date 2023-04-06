//
//  File.swift
//  
//
//  Created by Celan on 2023/04/04.
//

import Foundation

enum Constants {
    static let INTRO_ONBOARDING: [String] = [
        // TODO: - 앱 이름 나중에 바꿔주기
        "Welcome to GestaltFlowers(가명),\nwhere you can learn the basic of Gestalt Principles\nwith intuitive animation!\n\nThe Gestalt Principles are important because\nunderstanding these principles can improve\n'Mise-en-Scène', its functionality,\nand user-friendliness.\n",
//        "Each Gestalt Principle has an animated explanation\nwhich is well-designed with flower's movement.",
        "So you can interact at least 4 Gestalt Principles,\nand understand the basic of the principle.\n\nAnd of course,\nYou can find out the flower's information.\n\nRun this app when you want to know\nThe Gestalt Principle with beautiful animation\nand interaction.\n",
        "Each Principle has an animated explanation which is well-designed with flower's movement.",
        ""
    ]
    
    enum Gestalt {
        static let GESTALT_THEORIES: [String] = [
            "Similarity",
            "Continuation",
            "Closure",
            "Proximity",
            "Figure/Ground",
            "Prägnanz"
        ]
        
        static let SIMILARITY: String = "Similarity"
        static let CONTINUATION: String = "Continuation"
        static let CLOSURE: String = "Closure"
        static let PROXIMITY: String = "Proximity"
        static let FIGUREGROUND: String = "Figure/Ground"
        static let PRAGNANZ: String = "Prägnanz"
    }
    
    enum FlowerSeasons {
        static let SPRING: String = "Spring"
        static let SUMMER: String = "Summer"
        static let FALL: String = "Fall"
        static let WINTER: String = "Winter"
    }
}
