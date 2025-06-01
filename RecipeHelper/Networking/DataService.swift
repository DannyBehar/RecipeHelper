//
//  RecipeDataService.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/28/25.
//

import SwiftUI

protocol Fetchable {
    func fetchData(from urlString: String, forceRefresh: Bool) async throws -> Data
}

class DataService: Fetchable {
    let cachePath: String
    let diskCapacity: Int.Bytes
    
    lazy private var cache: URLCache = {
        URLCache(memoryCapacity: 0, diskCapacity: diskCapacity, diskPath: cachePath)
    }()
    
    init(cachePath: String, diskCapacity: Int.Bytes) {
        self.cachePath = cachePath
        self.diskCapacity = diskCapacity
    }
 
    func fetchData(from urlString: String, forceRefresh: Bool) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL("\(urlString) is not a valid URL")
        }
        
        let cachePolicy: URLRequest.CachePolicy = forceRefresh ? .reloadIgnoringLocalAndRemoteCacheData : .returnCacheDataElseLoad
        let request = URLRequest(url: url, cachePolicy: cachePolicy)
        
        if forceRefresh {
            return try await fetchAndStore(request: request)
        }
        
        if let cachedData = cache.cachedResponse(for: request)?.data {
            return cachedData
        }
        
        return try await fetchAndStore(request: request)
    }
    
    private func fetchAndStore(request: URLRequest) async throws -> Data {
        let (data, urlResopnse) = try await URLSession.shared.data(for: request)
        cache.storeCachedResponse(CachedURLResponse(response: urlResopnse, data: data), for: request)
        return data
    }
}
