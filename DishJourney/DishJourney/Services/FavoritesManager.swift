//
//  FavoritesManager.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 12/05/24.
//

import Foundation

class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()
    @Published private(set) var favorites: [Recipe] = []

    private let favoritesKey = "FavoriteRecipes"

    private init() {
        loadFavorites()
    }

    func toggleFavorite(recipe: Recipe) {
        if let index = favorites.firstIndex(where: { $0.uri == recipe.uri }) {
            favorites.remove(at: index)
        } else {
            favorites.append(recipe)
        }
        saveFavorites()
    }

    func isFavorite(recipe: Recipe) -> Bool {
        favorites.contains(where: { $0.uri == recipe.uri })
    }

    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }

    private func loadFavorites() {
        if let savedFavorites = UserDefaults.standard.data(forKey: favoritesKey),
           let decodedFavorites = try? JSONDecoder().decode([Recipe].self, from: savedFavorites) {
            favorites = decodedFavorites
        }
    }
}
