//
//  NetworkingError.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/31/25.
//

enum NetworkError: Error {
    case invalidURL(String)
    case invalidServerResponse(String)
    case decodingError(String)
}
