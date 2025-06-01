//
//  ShareRecipeModifier.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/31/25.
//

import SwiftUI

struct ShareRecipeView: View {
    let recipe: Recipe
    let thumbnail: Image
    
    var body: some View {
        Section {
            if let recipeUrlString = recipe.sourceUrl,
               let recipeUrl = URL(string: recipeUrlString) {
                ShareLink(item: recipeUrl, preview: SharePreview("\(recipe.name) (Recipe)", image: thumbnail)) {
                    Label("Share Recipe", systemImage: "richtext.page")
                }
            }
            
            if let youtubeUrlString = recipe.youtubeUrl,
               let youtubeUrl = URL(string: youtubeUrlString) {
                ShareLink(item: youtubeUrl, preview: SharePreview("\(recipe.name) (Youtube)", image: thumbnail)) {
                    Label("Share Youtube", systemImage: "play.rectangle")
                }
            }
        }
    }
}
