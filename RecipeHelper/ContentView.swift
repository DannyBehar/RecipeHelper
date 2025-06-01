//
//  ContentView.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/28/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = RecipeViewModel()
    
    var body: some View {
        NavigationStack {
            RecipeListView(viewModel: viewModel)
        }
        .task {
            await viewModel.fetchRecipes()
        }
    }
}

#Preview {
    ContentView()
}
