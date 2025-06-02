//
//  NetworkingError.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/31/25.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL(String)
    case invalidServerResponse(statusCode: Int)
    case decodingError(description: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL(let urlString): return "\(urlString) is not a valid URL"
        case .invalidServerResponse(let statusCode):  return "Server returned an invalid status code: \(statusCode)"
        case .decodingError(let description): return "Decoding Error: \(description)"
        }
    }
}
