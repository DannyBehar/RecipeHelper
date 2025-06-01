//
//  Recipe+Mock.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/28/25.
//

extension Recipe {
    static let allMocks: [Recipe] = [
        .apamBalik,
        .appleBlackberryCrumble,
        appleFrangipanTart,
        .bananaPancakes,
        tunisianOrangeCake,
        .strawberryRhubarbPie,
        .sugarPie
    ]
    
    static let apamBalik: Recipe = .init(uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                                         cuisine: "Malaysian",
                                         name: "Apam Balik",
                                         photoUrlLarge: "apam-balik-large",
                                         photoUrlSmall: "apam-balik-small",
                                         sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                                         youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    
    static let appleBlackberryCrumble: Recipe = .init(uuid: "599344f4-3c5c-4cca-b914-2210e3b3312f",
                                                      cuisine: "British",
                                                      name: "Apple & Blackberry Crumble",
                                                      photoUrlLarge: "apple-blackberry-crumble-large",
                                                      photoUrlSmall: "apple-blackberry-crumble-small")
    
    static let appleFrangipanTart: Recipe = .init(uuid: "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
                                                  cuisine: "British",
                                                  name: "Apple Frangipan Tart",
                                                  photoUrlLarge: "apple-frangipan-tart-large",
                                                  photoUrlSmall: "apple-frangipan-tart-small")
    
    static let bananaPancakes: Recipe = .init(uuid: "f8b20884-1e54-4e72-a417-dabbc8d91f12",
                                              cuisine: "American",
                                              name: "Banana Pancakes",
                                              photoUrlLarge: "banana-pancakes-large",
                                              photoUrlSmall: "banana-pancakes-small")
    
    static let tunisianOrangeCake: Recipe = .init(uuid: "a1bedde3-2bc6-46f9-ab3c-0d98a2b11b64",
                                         cuisine: "Tunisian",
                                         name: "Tunisian Orange Cake",
                                                  photoUrlLarge: "tunisian-orange-cake-large",
                                                  photoUrlSmall: "tunisian-orange-cake-small")
    
    static let strawberryRhubarbPie: Recipe = .init(uuid: "d2251700-21da-4931-9dc6-4d273643f5c7",
                                         cuisine: "British",
                                         name: "Strawberry Rhubarb Pie",
                                                  photoUrlLarge: "strawberry-rhubarb-pie-large",
                                                  photoUrlSmall: "strawberry-rhubarb-pie-small")
    
    static let sugarPie: Recipe = .init(uuid: "9f5a753e-472d-413e-a05b-ffbc8032e64c",
                                         cuisine: "Canadian",
                                         name: "Sugar Pie",
                                                  photoUrlLarge: "sugar-pie-large",
                                                  photoUrlSmall: "sugar-pie-small")
}
