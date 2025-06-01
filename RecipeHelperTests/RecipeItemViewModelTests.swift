//
//  RecipeItemViewModelTests.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/31/25.
//

import Testing
@testable import RecipeHelper

@MainActor @Suite("RecipeItemViewModel")
struct RecipeItemViewModelTests {
    @Test("initializes")
    func initializes() {
        let service = MockImageSuccessDataService()
        let subject = RecipeItemViewModel(dataService: service)
        
        #expect(subject.smallImage == nil,
        "small image should be nil after initialization")
        #expect(subject.largeImage == nil,
        "large image should be nil after initialization")
    }
    
    @MainActor @Suite("Fetch Image")
    struct FetchImageTests {
        @Test("successfully fetches small image")
        func fetchSmallImageSuccessfully() async throws {
            // given
            let service = MockImageSuccessDataService()
            let subject = RecipeItemViewModel(dataService: service)
            subject.smallImage = nil
            subject.largeImage = nil
            
            // when
            await subject.fetchImage(for: .apamBalik, size: .small)
            
            // then
            #expect(subject.smallImage != nil,
                    "small image should not be nil after loading successfully")
            
            #expect(subject.largeImage == nil,
                    "only small image should be loaded after fetching a small image")
        }
        
        @Test("successfully fetches large image")
        func fetchLargeImageSuccessfully() async throws {
            // given
            let service = MockImageSuccessDataService()
            let subject = RecipeItemViewModel(dataService: service)
            subject.smallImage = nil
            subject.largeImage = nil
            
            // when
            await subject.fetchImage(for: .apamBalik, size: .large)
            
            // then
            #expect(subject.largeImage != nil,
                    "large image should not be nil after loading successfully")
            
            #expect(subject.smallImage == nil,
                    "only large image should be loaded after fetching a large image")
        }
        
        @Test("fails to fetch small image")
        func fetchSmallImageFails() async throws {
            // given
            let service = MockFailureDataService()
            let subject = RecipeItemViewModel(dataService: service)
            subject.smallImage = nil
            subject.largeImage = nil
            
            // when
            await subject.fetchImage(for: .apamBalik, size: .small)
            
            // then
            #expect(subject.smallImage == nil,
                    "small image should be nil if loading fails")
        }
        
        @Test("fails to fetch large image")
        func fetchLargeImageFails() async throws {
            // given
            let service = MockFailureDataService()
            let subject = RecipeItemViewModel(dataService: service)
            subject.smallImage = nil
            subject.largeImage = nil
            
            // when
            await subject.fetchImage(for: .apamBalik, size: .large)
            
            // then
            #expect(subject.largeImage == nil,
                    "large image should be nil if loading fails")
        }
    }
}
