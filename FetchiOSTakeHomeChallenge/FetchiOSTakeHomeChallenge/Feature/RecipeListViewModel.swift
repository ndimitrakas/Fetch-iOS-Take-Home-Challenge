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
    
    @Published var state: ViewState = .empty
    private let apiService = RecipeAPIService()
    
    func fetchRecipes() async {
        if case .loading = state { return }
        state = .loading
        do {
            let recipes = try await apiService.fetchRecipes()
            if recipes.isEmpty {
                state = .empty
            } else {
                state = .success(recipes)
            }
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
