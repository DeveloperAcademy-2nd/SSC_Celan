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
        "Welcome to the \"Flowered Gestalts\", \nwhere you can learn the basic of Gestalt Principles with intuitive animation!\n\nThe Gestalt Principles are important because understanding these principles can improve these below.\n \n1. 🎨'Mise-en-Scène' \n2. ⚙️Product's functionality\n3. 👨‍👩‍👧‍👦User-friendliness",
        "Each principle can be learned through interactions that manipulate the shape of flowers.\nSo you can learn 6 Gestalt Principles through interaction, and understand the basic of the principle.",
        "You will learn 6 Gestlat Priniciples below. \n\n- The gestalt principle of 👯 Similarity\n- The gestalt principle of ❖ Proximity\n- The gestalt principle of 🧩 Closure\n- The gestalt principle of ➿ Continuity\n- The gestalt principle of 😶‍🌫️ Figure and Ground\n- The gestalt principle of ❅ Prägnanz",
        "Run this app when you want to know\nThe Gestalt Principles with beautiful animation and interaction."
    ]
    
    enum Gestalt {
        static let GESTALT_THEORIES: [String] = [
            "❖ Proximity",
            "👯 Similarity",
            "➿ Continuity",
            "🧩 Closure",
            "😶‍🌫️ Figure/Ground",
            "❅ Prägnanz"
        ]
        
        static let SIMILARITY: String = "👯 Similarity"
        static let CONTINUITY: String = "➿ Continuity"
        static let CLOSURE: String = "🧩 Closure"
        static let PROXIMITY: String = "❖ Proximity"
        static let FIGUREGROUND: String = "😶‍🌫️ Figure/Ground"
        static let PRAGNANZ: String = "❅ Prägnanz"
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
                // 가로 < 세로 == 세로모드
                return UIScreen.main.bounds.height / 5
            } else {
                // 가로 > 세로 == 가로모드 == 플레이그라운드
                return UIScreen.main.bounds.width / 7
            }
        }
        
        static var CURVE_HEIGHT: CGFloat {
            if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
                return UIScreen.main.bounds.width / 5 * 4
            } else {
                // 가로 > 세로 == 가로모드 == 플레이그라운드
                return UIScreen.main.bounds.height / 5 * 2.5
            }
        }
    }
    
    enum ClosureFlowerCGFloat {
        static var CLOSURE_WIDTH: CGFloat {
            if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
                return UIScreen.main.bounds.width / 3
            } else {
                // 가로 > 세로 == 가로모드 == 플레이그라운드
                return UIScreen.main.bounds.height / 3.5
            }
        }
        
        static var CLOSURE_HEIGHT: CGFloat {
            if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
                return UIScreen.main.bounds.height / 3
            } else {
                // 가로 > 세로 == 가로모드 == 플레이그라운드
                return UIScreen.main.bounds.width / 3.5
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
