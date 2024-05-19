//
//  RecipeRow.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 11/05/24.
//

import SwiftUI

struct RecipeRow: View {
    var recipe: Recipe
    @ObservedObject var favoritesManager = FavoritesManager.shared

    var body: some View {
        HStack {
            CachedImageView(urlString: recipe.image)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading) {
                Text(recipe.label).font(.headline)
                Text(recipe.source).font(.subheadline)
            }
            .padding(.leading, 8)

            Spacer()

            Button(
                action: {
                    favoritesManager.toggleFavorite(recipe: recipe)
                },
                label: {
                    Image(systemName: favoritesManager.isFavorite(recipe: recipe) ? "heart.fill" : "heart")
                        .foregroundColor(favoritesManager.isFavorite(recipe: recipe) ? .red : .gray)
                        .animation(.easeInOut, value: favoritesManager.isFavorite(recipe: recipe))
                }
            )
            .accessibilityIdentifier("FavoriteButton-\(recipe.uri)")
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing, 8)
        }
        .accessibilityIdentifier("RecipeRow-\(recipe.uri)")
    }
}
