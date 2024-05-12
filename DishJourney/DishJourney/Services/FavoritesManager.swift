//
//  FavoritesManager.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 12/05/24.
//

import Foundation

class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()
    @Published private(set) var favorites: Set<String> = []
    
    private let favoritesKey = "Favorites"

    private init() {
        let storedFavorites = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        favorites = Set(storedFavorites)
    }

    func toggleFavorite(for recipe: Recipe) {
        if favorites.contains(recipe.uri) {
            favorites.remove(recipe.uri)
        } else {
            favorites.insert(recipe.uri)
        }
        UserDefaults.standard.set(Array(favorites), forKey: favoritesKey)
    }

    func isFavorite(recipe: Recipe) -> Bool {
        return favorites.contains(recipe.uri)
    }
}
