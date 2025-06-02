//
//  RecipeItemViewModel.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/30/25.
//

import SwiftUI

@MainActor
class RecipeItemViewModel: ObservableObject {
    @Published var smallImage: UIImage?
    @Published var largeImage: UIImage?
    
    let dataService: ImageFetchable
    
    init(dataService: ImageFetchable = ImageService()) {
        self.dataService = dataService
    }
    
    func fetchImage(for recipe: Recipe, size: RecipeImageSize) async {
        guard image(for: size) == nil,
        let urlString = recipe.getPhotoUrlString(for: size) else { return }
        
        do {
            let uiImage = try await dataService.fetchImage(from: urlString)
            
            switch size {
            case .small: smallImage = uiImage
            case .large: largeImage = uiImage
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func image(for size: RecipeImageSize) -> UIImage? {
        switch size {
        case .small: smallImage
        case .large: largeImage
        }
    }
}
