//
//  RecipeListViewModel.swift
//  FetchiOSTakeHomeChallenge
//
//  Created by Nick Dimitrakas on 1/28/25.
//

import Foundation
import UIKit

@MainActor
class RecipeListViewModel: ObservableObject, ImageLoader {
    
    enum ViewState {
        case loading
        case success([Recipe])
        case empty
        case error(String)
    }
    
    @Published var state: ViewState = .loading
    @Published var recipes: [Recipe] = []
    private let apiService = RecipeAPIService()
    private let imageCache = ImageCache()
    
    func fetchRecipes() async {
        state = .loading
        do {
            self.recipes = try await apiService.fetchRecipes()
            if self.recipes.isEmpty {
                state = .empty
            } else {
                state = .success(self.recipes)
            }
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    func loadImage(from url: URL) async -> UIImage? {
        return await imageCache.loadImage(from: url)
    }
}
