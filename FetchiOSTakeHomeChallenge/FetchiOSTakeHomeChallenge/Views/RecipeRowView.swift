//
//  RecipeRowView.swift
//  FetchiOSTakeHomeChallenge
//
//  Created by Nick Dimitrakas on 1/28/25.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            AsyncImageView(url: recipe.photoURLSmall)
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text(recipe.cuisine)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

//#Preview {
//    RecipeRowView()
//}
