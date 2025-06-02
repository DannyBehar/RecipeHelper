//
//  RecipeDataService.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/28/25.
//

import Foundation

protocol RecipeFetchable {
    func fetchData(from urlString: String, forceRefresh: Bool) async throws -> RecipeResponse
}

class RecipeService: RecipeFetchable {
    lazy private var cache: URLCache = {
        URLCache(memoryCapacity: 0, diskCapacity: 10.megabytes, diskPath: "recipeDataCache")
    }()
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init() {
    }
 
    func fetchData(from urlString: String, forceRefresh: Bool) async throws -> RecipeResponse {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL(urlString)
        }
        
        let cachePolicy: URLRequest.CachePolicy = forceRefresh ? .reloadIgnoringLocalAndRemoteCacheData : .returnCacheDataElseLoad
        let request = URLRequest(url: url, cachePolicy: cachePolicy)
        
        if forceRefresh {
            return try await fetchAndStore(request: request)
        }
        
        if let cachedData = cache.cachedResponse(for: request)?.data {
            return try decodeData(cachedData, for: request)
        }
        
        return try await fetchAndStore(request: request)
    }
    
    private func fetchAndStore(request: URLRequest) async throws -> RecipeResponse {
        let (data, response) = try await URLSession.shared.fetchData(for: request)
        
        let decodedData = try decodeData(data, for: request)
        
        cache.storeCachedResponse(CachedURLResponse(response: response, data: data), for: request)
       
        return decodedData
    }
    
    private func decodeData(_ data: Data, for request: URLRequest) throws -> RecipeResponse {
        do {
            return try decoder.decode(RecipeResponse.self, from: data)
        } catch {
            throw NetworkError.decodingError(description: error.localizedDescription)
        }
    }
}
