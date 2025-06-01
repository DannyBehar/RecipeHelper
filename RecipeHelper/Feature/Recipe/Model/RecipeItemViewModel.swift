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
    
    let dataService: Fetchable
    
    init(dataService: Fetchable = DataService(cachePath: "imageDataCache", diskCapacity: 100.megabytes)) {
        self.dataService = dataService
    }
    
    func fetchImage(for recipe: Recipe, size: RecipeImageSize) async {
        guard image(for: size) == nil else { return }
        
        guard let urlString = recipe.getPhotoUrlString(for: size),
              let imageData = try? await dataService.fetchData(from: urlString, forceRefresh: false) else { return }
        
        switch size {
        case .small: smallImage = UIImage(data: imageData)
        case .large: largeImage = UIImage(data: imageData)
        }
    }
    
    private func image(for size: RecipeImageSize) -> UIImage? {
        switch size {
        case .small: smallImage
        case .large: largeImage
        }
    }
}
