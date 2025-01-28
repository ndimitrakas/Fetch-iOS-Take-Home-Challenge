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
        List {
            Text("Here")
        }
        .refreshable {
            // TODO: call the api again and load everything again, possibly from the cache.
            print("do refresh work here")
        }
    }
}

#Preview {
    RecipeListView()
}
