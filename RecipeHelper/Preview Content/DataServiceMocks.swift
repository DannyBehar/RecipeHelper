//
//  DataServiceMocks.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/28/25.
//

import SwiftUI

class MockSuccessDataService: RecipeFetchable {
    func fetchData(from urlString: String, forceRefresh: Bool) async throws -> RecipeResponse {
        return RecipeResponse(recipes: Recipe.allMocks)
    }
}

class MockFailureDataService: RecipeFetchable {
    func fetchData(from urlString: String, forceRefresh: Bool) async throws -> RecipeResponse {
        throw NetworkError.invalidURL("Invalid URL")
    }
}

class MockImageSuccessDataService: ImageFetchable {
    func fetchImage(from urlString: String) async throws -> UIImage {
        UIImage(named: "banana-pancakes-small")!
    }
}

class MockImageFailureDataService: ImageFetchable {
    func fetchImage(from urlString: String) async throws -> UIImage {
        throw NetworkError.invalidURL("Invalid URL")
    }
}
