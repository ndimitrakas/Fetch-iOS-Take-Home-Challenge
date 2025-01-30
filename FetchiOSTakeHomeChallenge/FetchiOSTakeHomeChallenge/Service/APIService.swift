//
//  APIService.swift
//  FetchiOSTakeHomeChallenge
//
//  Created by Nick Dimitrakas on 1/28/25.
//

import Foundation

struct RecipeAPIService {
    private let url: URL
        
    init(urlString: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") {
        guard let validURL = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        self.url = validURL
    }
    
    func fetchRecipes() async throws -> [Recipe] {
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(RecipeResponse.self, from: data)
        return response.recipes
    }
}

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}
