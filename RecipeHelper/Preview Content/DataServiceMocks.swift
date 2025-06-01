//
//  DataServiceMocks.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/28/25.
//

import SwiftUI

class MockSuccessDataService: Fetchable {
    func fetchData(from urlString: String, forceRefresh: Bool) async throws -> Data {
        let url = Bundle.main.url(forResource: "recipes", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
}

class MockFailureDataService: Fetchable {
    func fetchData(from urlString: String, forceRefresh: Bool) async throws -> Data {
        throw NetworkError.invalidURL("Invalid URL")
    }
}

class MockImageSuccessDataService: Fetchable {
    func fetchData(from urlString: String, forceRefresh: Bool) async throws -> Data {
        let uiImage = UIImage(named: "banana-pancakes-small")!
        let pngData = uiImage.pngData()!
        return pngData
    }
}
