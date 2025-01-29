//
//  RecipeListViewModel.swift
//  FetchiOSTakeHomeChallenge
//
//  Created by Nick Dimitrakas on 1/28/25.
//

import Foundation
import UIKit

@MainActor
class RecipeListViewModel: ObservableObject {
    
    enum ViewState {
        case loading
        case success([Recipe])
        case empty
        case error(String)
    }
    
    @Published var state: ViewState = .loading
    @Published var recipes: [Recipe] = []
    private let apiService = RecipeAPIService()
    
    func fetchRecipes() async {
        guard case .loading = state else { return }
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
}
