//
//  QuestionData.swift
//  Personality_Quiz_Toure
//
//  Created by Sheick on 11/17/20.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: AnimalType
}

enum AnimalType: Character {
    case alligator = "🐊", baldEagle = "🦅", camel = "🐪", lion = "🦁"

    var definition: String {
        switch self {
        case .alligator:
            return "Just like how this animal continues to grow in size over time, you too continue to practice self growth as you make it your mission to ensure that each year in your life is three folds better than the previous one. You speak your mind whenever the call of action is needed, you do not shy away from confrontation."
        case .baldEagle:
            return "Your eyes see everything, and your premonitions is clear. You fly high above all negativty and only scoop down if you are seeking a prey."
        case .camel:
            return "You can carry the weight of many obstacles that come your way, the best thing about you is your ability to remain resilient for a long period of time."
        case .lion:
            return "You sought to rule all things before you. You take pride in your ability to handle situations with an authoritative tone."
        }
    }
}
