//
//  FavoritesViewModel.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 12/05/24.
//

import Foundation
import Combine

class FavoritesViewModel: ObservableObject {
  @Published var favorites: [Recipe] = []
  private var cancellables = Set<AnyCancellable>()

  init() {
    loadFavorites()
    FavoritesManager.shared.$favorites
      .sink { [weak self] updatedFavorites in
        self?.favorites = updatedFavorites
      }
      .store(in: &cancellables)
  }

  func toggleFavorite(_ recipe: Recipe) {
    FavoritesManager.shared.toggleFavorite(recipe: recipe)
  }

  func isFavorite(_ recipe: Recipe) -> Bool {
    return FavoritesManager.shared.isFavorite(recipe: recipe)
  }

  private func loadFavorites() {
    favorites = FavoritesManager.shared.favorites
  }

  func removeFavorites(at offsets: IndexSet) {
    offsets.forEach { index in
      let recipe = favorites[index]
      toggleFavorite(recipe)
    }
  }
}
