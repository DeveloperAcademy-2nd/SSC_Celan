//
//  File.swift
//  
//
//  Created by Celan on 2023/04/04.
//

import Foundation
import SwiftUI

enum Constants {
    static let INTRO_ONBOARDING: [String] = [
        // TODO: - 앱 이름 나중에 바꿔주기
        "Welcome to GestaltFlowers(가명),\nwhere you can learn the basic of Gestalt Principles\nwith intuitive animation!\n\nThe Gestalt Principles are important because\nunderstanding these principles can improve\n'Mise-en-Scène', its functionality,\nand user-friendliness.\n",
        "Each Principle has an animated explanation\nwhich is well-designed with flower's movement.",
        "So you can interact at least 4 Gestalt Principles,\nand understand the basic of the principle.\n\nAnd of course,\nYou can find out the flower's information.\n\nRun this app when you want to know\nThe Gestalt Principle with beautiful animation\nand interaction.\n",
        ""
    ]
    
    enum Gestalt {
        static let GESTALT_THEORIES: [String] = [
            "Similarity",
            "Continuity",
            "Closure", // Done
            "Proximity", // Doing
            "Figure/Ground",
            "Prägnanz"
        ]
        
        static let SIMILARITY: String = "Similarity"
        static let CONTINUITY: String = "Continuity"
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
    
    enum CurveCGFloat {
        static var CURVE_WIDTH: CGFloat {
            if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
                return UIScreen.main.bounds.height / 5
            } else {
                return UIScreen.main.bounds.width / 5
            }
        }
        
        static var CURVE_HEIGHT: CGFloat {
            if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
                return UIScreen.main.bounds.height / 5 * 3
            } else {
                return UIScreen.main.bounds.width / 5 * 3
            }
        }
    }
    
    enum ClosureFlowerCGFloat {
        static var CLOSURE_WIDTH: CGFloat {
            if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
                return UIScreen.main.bounds.width / 3
            } else {
                return UIScreen.main.bounds.height / 3
            }
        }
        
        static var CLOSURE_HEIGHT: CGFloat {
            if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
                return UIScreen.main.bounds.height / 3
            } else {
                return UIScreen.main.bounds.width / 3
            }
        }
    }
    
    enum ReactiveCGFloat {
        static var REACTIVE_WIDTH: CGFloat {
            if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
                return UIScreen.main.bounds.width
            } else {
                return UIScreen.main.bounds.height
            }
        }
        
        static var REACTIVE_HEIGHT: CGFloat {
            if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
                return UIScreen.main.bounds.height
            } else {
                return UIScreen.main.bounds.width
            }
        }
    }
}
