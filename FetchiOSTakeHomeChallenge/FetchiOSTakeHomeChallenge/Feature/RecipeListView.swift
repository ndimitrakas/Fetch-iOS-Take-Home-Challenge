//
//  ContentView.swift
//  FetchiOSTakeHomeChallenge
//
//  Created by Nick Dimitrakas on 1/27/25.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject var recipeListViewModel = RecipeListViewModel()
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Recipes")
                .refreshable {
                    recipeListViewModel.recipes = []
                    await recipeListViewModel.fetchRecipes()
                }
        }
        .task {
            await recipeListViewModel.fetchRecipes()
        }
        .environmentObject(recipeListViewModel)
    }
    
    @ViewBuilder
    private var content: some View {
        switch recipeListViewModel.state {
            
        case .loading:
            ProgressView("Loading Recipes")
        case .empty:
            Text("No Recipes Available")
        case .success(let recipes):
            List(recipes) { recipe in
                RecipeRowView(recipe: recipe)
            }
        case .error(let message):
            Text(message)
                .foregroundColor(.red)
        }
    }
}

#Preview {
    RecipeListView()
}
