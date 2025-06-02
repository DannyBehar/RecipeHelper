//
//  URLSession+FetchData.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 6/1/25.
//

import Foundation

extension URLSession {
    func fetchData(for request: URLRequest) async throws -> (Data, URLResponse) {
        let (data, response) = try await self.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            throw NetworkError.invalidServerResponse("Server returned an invalid response: \(statusCode)")
        }
        
        return (data, response)
    }
}
