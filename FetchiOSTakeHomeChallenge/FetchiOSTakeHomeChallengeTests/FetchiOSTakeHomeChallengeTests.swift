//
//  FetchiOSTakeHomeChallengeAPIServiceTests.swift
//  FetchiOSTakeHomeChallengeTests
//
//  Created by Nick Dimitrakas on 1/27/25.
//

import Testing
@testable import FetchiOSTakeHomeChallenge

struct FetchiOSTakeHomeChallengeAPIServiceTests {

    let apiService = RecipeAPIService()
    let emptyAPIService = RecipeAPIService(urlString: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
    let malformedAPIService = RecipeAPIService(urlString: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")

    
    @Test func testFetchRecipes_Success() async throws {
        let recipes = try await apiService.fetchRecipes()
        
        #expect(recipes.count > 0)
        #expect(recipes.first?.name != nil)
    }

    @Test func testFetchRecipes_Empty() async throws {
        let recipes = try await emptyAPIService.fetchRecipes()
        
        #expect(recipes.isEmpty)
    }

    @Test func testFetchRecipes_Malformed() async throws {
        await #expect(throws: DecodingError.self) {
            _ = try await malformedAPIService.fetchRecipes()
        }
    }
}
