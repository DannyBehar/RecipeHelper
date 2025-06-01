//
//  ContentUnavailableView.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/30/25.
//

import SwiftUI

struct RecipeUnavailableView: View {
    let title: LocalizedStringKey
    let systemImage: String
    let description: LocalizedStringKey
    
    init(_ title: LocalizedStringKey, systemImage: String, description: LocalizedStringKey) {
        self.title = title
        self.systemImage = systemImage
        self.description = description
    }
    
    init(reason: Reason) {
        self.title = reason.headerString
        self.systemImage = reason.iconString
        self.description = reason.instructions
    }
    
    static func search(_ query: String) -> RecipeUnavailableView {
        .init(reason: .search(query: query))
    }
    
    static func error() -> RecipeUnavailableView {
        .init(reason: .error)
    }
    
    static func empty() -> RecipeUnavailableView {
        .init(reason: .empty)
    }
    
    enum Reason {
        case error
        case search(query: String)
        case empty
        
        var iconString: String {
            switch self {
            case .search: "magnifyingglass"
            case .error: "exclamationmark.triangle"
            case .empty: "fork.knife"
            }
        }
        
        var headerString: LocalizedStringKey {
            switch self {
            case let .search(query): "No results for: '\(query)'"
            case .empty: "Nothing here"
            case .error: "Well, this is embarassing..."
            }
        }
        
        var instructions: LocalizedStringKey {
            switch self {
            case .search: "Check the spelling or try a new search."
            case .empty: "We are cooking up something special! Check back soon!"
            case .error: "There was an issue getting the latest recipes. Please try again later."
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if #available(iOS 17.0, *) {
                ContentUnavailableView(title, systemImage: systemImage, description: Text(description))
            } else {
                VStack(spacing: Spacing.medium) {
                    Image(systemName: systemImage)
                        .font(.system(size: 48))
                        .bold()
                        .foregroundStyle(.secondary)
                        .imageScale(.large)
                    
                    VStack(spacing: Spacing.small) {
                        Text(title)
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.primary)
                        
                        Text(description)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(Spacing.extraLarge)
            }
        }
    }
}

#Preview("Search") {
   RecipeUnavailableView.search("Testing")
}

#Preview("Error") {
    RecipeUnavailableView.error()
}

#Preview("Empty") {
    RecipeUnavailableView.empty()
}
