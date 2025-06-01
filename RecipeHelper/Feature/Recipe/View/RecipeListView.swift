//
//  RecipeListView.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/28/25.
//

import SwiftUI

struct RecipeListView: View {
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        VStack {
            switch viewModel.status {
            case .loading:
                Text("Loading!!!")
            case .fetched:
                if viewModel.recipes.isEmpty {
                    emptyStateView
                } else if viewModel.filteredRecipes.isEmpty {
                    RecipeUnavailableView.search(viewModel.searchText)
                } else {
                    ScrollViewReader { proxy in
                        List {
                            Section {
                                ForEach(viewModel.filteredRecipes) { recipe in
                                    RecipeItemView(recipe)
                                }
                            }
                            .listSectionSeparator(.hidden, edges: .top)
                        }
                        .listStyle(.plain)
                        .onChange(of: viewModel.selectedCuisine) { _ in
                            guard let firstRecipeId = viewModel.filteredRecipes.first?.id else {
                                return
                            }

                            withAnimation {
                                proxy.scrollTo(firstRecipeId, anchor: .bottom)
                            }
                        }
                    }
                }
            case .error:
                errorStateView
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(spacing: 4) {
                    Image(systemName: "fork.knife")
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
               filterByCuisinePicker
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText)
        .environmentObject(viewModel)
        .refreshable {
            await viewModel.fetchRecipes(forceRefresh: true)
        }
    }
    
    var filterByCuisinePicker: some View {
        Group {
            if #available(iOS 18.0, *) {
                Picker("Filter by Cuisine", selection: $viewModel.selectedCuisine) {
                    HStack {
                        Image(systemName: "globe.desk")
                        Text("All")
                            .bold()
                    }
                    .tag(nil as Cuisine?)
                    
                    ForEach(viewModel.availableCuisines, id: \.self) { cuisine in
                        HStack {
                            Image(systemName: cuisine.icon)
                            Text(cuisine.label)
                        }
                        .tag(cuisine as Cuisine?)
                    }
                } currentValueLabel: {
                    Label(viewModel.selectedCuisine?.label ?? "All",
                          systemImage: viewModel.selectedCuisine?.icon ?? "globe.desk")
                    .labelStyle(.titleOnly)
                }
            } else {
                Picker("Filter by Cuisine", selection: $viewModel.selectedCuisine) {
                    HStack {
                        Text("All")
                            .bold()
                    }
                    .tag(nil as Cuisine?)
                    ForEach(viewModel.availableCuisines, id: \.self) { cuisine in
                        Text(cuisine.label)
                            .tag(cuisine as Cuisine?)
                    }
                }
            }
        }
        .pickerStyle(.menu)
    }
    
    var errorStateView: some View {
        VStack {
            RecipeUnavailableView.error()
            tryAgainButton
            .padding(.bottom, Spacing.small)
        }
    }
    
    var emptyStateView: some View {
        VStack {
            RecipeUnavailableView.empty()
            tryAgainButton
                .padding(.bottom, Spacing.small)
        }
        .padding()
    }
    
    var tryAgainButton: some View {
        Button("Try Again") {
            Task {
                await viewModel.fetchRecipes(forceRefresh: true)
            }
        }
        .bold()
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    NavigationStack {
        RecipeListView(viewModel: RecipeViewModel(dataService: MockSuccessDataService()))
    }
}
