//
//  RecipeViewModel.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/28/25.
//

import SwiftUI

@MainActor
class RecipeViewModel: ObservableObject {
    enum Status {
        case initial
        case loading
        case fetched
        case error
    }
    
    @Published var recipes: [Recipe] = []
    @Published var searchText = ""
    @Published var selectedCuisine: Cuisine? = nil
    @Published var status: Status = .initial
    
    let recipeUrl = Constants.recipesUrlString
    let dataService: RecipeFetchable
    
    init(dataService: RecipeFetchable = RecipeService()) {
        self.dataService = dataService
    }
    
    var shouldPresentLongerLoadingTime: Bool {
        status == .initial ||
        status == .error ||
        (status == .fetched && recipes.isEmpty)
    }
    
    var filteredRecipes: [Recipe] {
        let filteredByCuisine: [Recipe] = {
            guard let selectedCuisine else { return recipes }
            
            return recipes.filter {
                $0.cuisineType == selectedCuisine
            }
        }()
        
        guard !searchText.isEmpty else {
            return filteredByCuisine
        }
        
        return filteredByCuisine.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    var availableCuisines: [Cuisine] {
        Set(recipes.compactMap(\.cuisineType)).sorted(by: { $0.rawValue < $1.rawValue })
    }
    
    func fetchRecipes(forceRefresh: Bool = false,
                      delay: Double = 2.0) async {
        do {
            // If loading from error or empty state, give user a longer loading time so they know that subsequent requests went through
            if shouldPresentLongerLoadingTime {
                status = .loading
                await Task.sleep(seconds: delay)
            }
            
            let recipeResponse: RecipeResponse = try await dataService.fetchData(from: recipeUrl, forceRefresh: forceRefresh)
            recipes = recipeResponse.recipes
            status = .fetched
        } catch {
            print(error.localizedDescription)
            status = .error
        }
    }
}
