//
//  Cuisine.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/29/25.
//

enum Cuisine: Hashable {
    case american
    case british
    case canadian
    case croatian
    case french
    case greek
    case italian
    case malaysian
    case mexican
    case polish
    case portuguese
    case russian
    case tunisian
    case unknown(String)
    
    init(rawValue: String) {
        let lowercased = rawValue.lowercased()
        switch lowercased {
        case Cuisine.american.rawValue: self = .american
        case Cuisine.british.rawValue: self = .british
        case Cuisine.canadian.rawValue: self = .canadian
        case Cuisine.croatian.rawValue: self = .croatian
        case Cuisine.french.rawValue: self = .french
        case Cuisine.greek.rawValue: self = .greek
        case Cuisine.italian.rawValue: self = .italian
        case Cuisine.malaysian.rawValue: self = .malaysian
        case Cuisine.mexican.rawValue: self = .mexican
        case Cuisine.polish.rawValue: self = .polish
        case Cuisine.portuguese.rawValue: self = .portuguese
        case Cuisine.russian.rawValue: self = .russian
        case Cuisine.tunisian.rawValue: self = .tunisian
        default: self = .unknown(lowercased)
        }
    }
    
    var rawValue: String {
        switch self {
        case .american: "american"
        case .british: "british"
        case .canadian: "canadian"
        case .croatian: "croatian"
        case .french: "french"
        case .greek: "greek"
        case .italian: "italian"
        case .malaysian: "malaysian"
        case .mexican: "mexican"
        case .polish: "polish"
        case .portuguese: "portuguese"
        case .russian: "russian"
        case .tunisian: "tunisian"
        case .unknown(let string): string.lowercased()
        }
    }
    
    var label: String {
        rawValue.capitalized
    }
    
    var icon: String {
        switch self {
        case .american, .canadian, .mexican: "globe.americas"
        case .british, .croatian, .french, .greek, .italian, .polish, .portuguese, .tunisian: "globe.europe.africa"
        case .malaysian, .russian: "globe.asia.australia"
        case .unknown: "globe.desk"
        }
    }
}
