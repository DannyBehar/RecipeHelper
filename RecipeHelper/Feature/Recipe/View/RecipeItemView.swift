//
//  RecipeItemView.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/28/25.
//

import SwiftUI

struct RecipeItemView: View {
    @StateObject var viewModel = RecipeItemViewModel()
    @ScaledMetric var imageSize = Constants.listItemImageSize
    
    let recipe: Recipe
    
    init(_ recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        NavigationLink(destination: RecipeDetailView(uiImage: viewModel.largeImage, recipe: recipe)) {
            VStack {
                HStack {
                    ImageWithPlaceholder(uiImage: viewModel.smallImage)
                        .frame(width: imageSize, height: imageSize)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(alignment: .leading) {
                        Text(recipe.name)
                            .font(.headline)
                            .foregroundStyle(.primary)
                        
                        Text(recipe.cuisine)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .contextMenu {
            ShareRecipeView(recipe: recipe, thumbnail: thumbnailImage)
        }
        .task {
            await viewModel.fetchImage(for: recipe, size: .small)
            await viewModel.fetchImage(for: recipe, size: .large)
        }
    }
    
    var thumbnailImage: Image {
        if let smallUIImage = viewModel.smallImage {
            Image(uiImage: smallUIImage)
        } else {
            Image(uiImage: UIImage())
        }
    }
}

#Preview {
    RecipeItemView(Recipe.allMocks.first!)
}
