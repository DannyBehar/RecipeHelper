//
//  RecipeViewModelTests.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/31/25.
//

import Testing
@testable import RecipeHelper

@MainActor @Suite("RecipeViewModel")
struct RecipeViewModelTests {
    let subject = RecipeViewModel()
    
    @Test("initializes")
    func initialization() async throws {
        #expect(subject.recipes.isEmpty, "Should initialize with an empty list of recipes.")
        #expect(subject.searchText.isEmpty, "Should initialize with an empty search text.")
        #expect(subject.selectedCuisine == nil, "Should initialize with no selected cuisine.")
        #expect(subject.status == .initial, "Should initialize in initial status.")
    }
    
    @MainActor @Suite("Should present longer loading time")
    struct ShouldPresentLongerLoadingTimeTests {
        let subject = RecipeViewModel()
        
        @Test("when in initial status")
        func shouldWaitLongerToLoad_whenInInitialStatus() {
            // given
            subject.status = .initial
            
            // when
            let shouldPresentLongerLoadingTime = subject.shouldPresentLongerLoadingTime
            
            // then
            #expect(shouldPresentLongerLoadingTime == true,
                    "When a user starts the app, they should be presented with a longer loading time.")
        }
        
        @Test("when in error status")
        func shouldWaitLongerToLoad_whenInErrorStatus() {
            // given
            subject.status = .error
            
            // when
            let shouldPresentLongerLoadingTime = subject.shouldPresentLongerLoadingTime
            
            // then
            #expect(shouldPresentLongerLoadingTime == true,
                    "When a user retries after an error, they should be presented with a longer loading time.")
        }
        
        @Test("when user retries in empty state")
        func shouldPresentLongerLoadingTime_whenUserRetriesInFetchedButEmptyState() {
            // given
            subject.status = .fetched
            subject.recipes = []
            
            // when
            let shouldPresentLongerLoadingTime = subject.shouldPresentLongerLoadingTime
            
            // then
            #expect(shouldPresentLongerLoadingTime == true,
                    "When a user retries after loading into an empty state, they should be presented with a longer loading time.")
        }
        
        @Test("should not occur when refreshing a populated list")
        func shouldPresentLongerLoadingTime_whenInFetchedAndPopulatedState() {
            // given
            subject.status = .fetched
            subject.recipes = Recipe.allMocks
            
            // when
            let shouldPresentLongerLoadingTime = subject.shouldPresentLongerLoadingTime
            
            // then
            #expect(shouldPresentLongerLoadingTime == false,
                    "When a user refreshes recipe list, they should not be presented with a longer loading time.")
        }
    }
    
    @MainActor @Suite("Available cuisines")
    struct AvailableCuisinesTests {
        let subject = RecipeViewModel()
        
        @Test("should not contain duplicates")
        func availableCuisines_shouldNotContainDuplicates() {
            // given
            subject.recipes = [.appleBlackberryCrumble, .tunisianOrangeCake, .appleFrangipanTart]
            
            // when
            let availableCuisines = subject.availableCuisines
            
            // then
            #expect(availableCuisines == [.british, .tunisian],
                    "Available cuisines should not contain duplicates.")
        }
        
        @Test("should be sorted alphabetically")
        func availableCuisines_shouldBeSortedAlphabetically() {
            // given
            subject.recipes = [.tunisianOrangeCake, .appleFrangipanTart, .bananaPancakes, .apamBalik]
            
            // when
            let availableCuisines = subject.availableCuisines
            
            // then
            #expect(availableCuisines == [.american, .british, .malaysian, .tunisian],
                    "Available cuisines should be sorted alphabetically.")
        }
    }
    
    @MainActor @Suite("Filtered recipes")
    struct FilteredRecipesTests {
        let subject = RecipeViewModel()
        
        @Test("shows all recipes when search text is empty")
        func filteredRecipes_showsAllRecipesWhenSearchTextIsEmpty() {
            // given
            subject.recipes = Recipe.allMocks
            subject.selectedCuisine = nil
            subject.searchText = ""
            
            // when
            let filteredRecipes = subject.filteredRecipes
            
            // then
            #expect(filteredRecipes == Recipe.allMocks,
                    "Filtered Recipes should show all recipes when search text is empty.")
        }
        
        @Test("shows recipes matching search term")
        func filteredRecipes_showsRecipesMatchingSearchTerm() {
            // given
            subject.recipes = [.apamBalik, .bananaPancakes, .tunisianOrangeCake, .appleBlackberryCrumble]
            subject.searchText = "banana"
            
            // when
            let filteredRecipes = subject.filteredRecipes
            
            // then
            #expect(filteredRecipes == [.bananaPancakes],
                    "Filtered Recipes should show recipes matching search term.")
        }
        
        @Test("shows recipes matching selected cuisine")
        func filteredRecipes_showsRecipesMatchingSelectedCuisine() {
            // given
            subject.recipes = [.apamBalik, .bananaPancakes, .tunisianOrangeCake, .appleBlackberryCrumble]
            subject.selectedCuisine = .american
            
            // when
            let filteredRecipes = subject.filteredRecipes
            
            // then
            #expect(filteredRecipes == [.bananaPancakes],
                    "Filtered Recipes should show recipes matching selected cuisine.")
        }
        
        @Test("shows recipes matching search and selected cuisine")
        func filteredRecipes_showsRecipesMatchingSearchAndSelectedCuisine() {
            // given
            subject.recipes = Recipe.allMocks
            subject.searchText = "pie"
            subject.selectedCuisine = .british
            
            // when
            let filteredRecipes = subject.filteredRecipes
            
            // then
            #expect(filteredRecipes == [.strawberryRhubarbPie],
                    "Filtered Recipes should show recipes matching search and selected cuisine.")
            
        }
    }
    
    @MainActor @Suite("Fetch Recipes")
    struct FetchRecipesTests {
        @Test("successfully fetches recipes")
        func fetchRecipesSuccessfully() async throws {
            // given
            let service = MockSuccessDataService()
            let subject = RecipeViewModel(dataService: service)
            
            // when
            await subject.fetchRecipes(delay: 0.0)
            
            // then
            #expect(subject.recipes.isEmpty == false,
            "Recipes should not be empty after successful fetching")
            
            #expect(subject.status == RecipeViewModel.Status.fetched,
            "Status should be fetched after successful fetching")
        }
        
        @Test("updates status upon failure")
        func fetchRecipesFails() async throws {
            // given
            let service = MockFailureDataService()
            let subject = RecipeViewModel(dataService: service)
            
            // when
            await subject.fetchRecipes(delay: 0.0)
            
            // then
            #expect(subject.status == RecipeViewModel.Status.error)
        }
        
    }
}
