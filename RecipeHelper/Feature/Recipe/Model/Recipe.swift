//
//  Recipe.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/28/25.
//

import Foundation

struct Recipe: Decodable, Identifiable, Equatable {
    var id: String { uuid }
    let uuid: String
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let youtubeUrl: String?
    
    init(uuid: String,
         cuisine: String,
         name: String,
         photoUrlLarge: String? = nil,
         photoUrlSmall: String? = nil,
         sourceUrl: String? = nil,
         youtubeUrl: String? = nil) {
        self.uuid = uuid
        self.cuisine = cuisine
        self.name = name
        self.photoUrlLarge = photoUrlLarge
        self.photoUrlSmall = photoUrlSmall
        self.sourceUrl = sourceUrl
        self.youtubeUrl = youtubeUrl
    }
    
    var cuisineType: Cuisine {
        Cuisine(rawValue: cuisine)
    }
    
    func getPhotoUrlString(for size: RecipeImageSize) -> String? {
        switch size {
        case .small: photoUrlSmall
        case .large: photoUrlLarge
        }
    }
}

enum RecipeImageSize {
    case small, large
}
