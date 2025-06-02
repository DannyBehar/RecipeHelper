//
//  ImageService.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 6/1/25.
//

import Foundation
import UIKit

protocol ImageFetchable {
    func fetchImage(from urlString: String) async throws -> UIImage
}

class ImageService: ImageFetchable {
    lazy private var cache: URLCache = {
        URLCache(memoryCapacity: 0, diskCapacity: 100.megabytes, diskPath: "imageDataCache")
    }()
    
    init() {
    }
 
    func fetchImage(from urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL("\(urlString) is not a valid URL")
        }
        
        let cachePolicy: URLRequest.CachePolicy =  .returnCacheDataElseLoad
        let request = URLRequest(url: url, cachePolicy: cachePolicy)
        
        if let cachedData = cache.cachedResponse(for: request)?.data {
            guard let uiImage = UIImage(data: cachedData) else {
                throw NetworkError.decodingError(description: "Unable to decode image for URL: \(urlString)")
            }
            return uiImage
        }
        
        return try await fetchAndStore(request: request)
    }
    
    private func fetchAndStore(request: URLRequest) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.fetchData(for: request)
        guard let uiImage = UIImage(data: data) else {
            let urlString = request.url?.absoluteString ?? "Unknown URL"
            throw NetworkError.decodingError(description: "Unable to decode image for URL: \(urlString)")
        }
        cache.storeCachedResponse(CachedURLResponse(response: response, data: data), for: request)
        return uiImage
    }
}
