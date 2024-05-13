//
//  RecipesViewModel.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 12/05/24.
//

import Combine
import SwiftUI

class RecipesViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    @Published var ingredient = ""
    @Published var ingredients = [String]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showIngredientWarning = false
    
    private var cancellables = Set<AnyCancellable>()

    func addIngredient() {
        let cleanedIngredient = ingredient.trimmingCharacters(in: .whitespacesAndNewlines)
        if !cleanedIngredient.isEmpty && !ingredients.contains(cleanedIngredient) {
            withAnimation(.spring()) {
                ingredients.append(cleanedIngredient)
                ingredient = ""
            }
        }
    }

    func fetchRecipes() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                let apiService = ApiService()
                let fetchedRecipes = try await apiService.fetchRecipes(query: ingredients.joined(separator: ", "))
                DispatchQueue.main.async {
                    self.recipes = fetchedRecipes
                    if self.recipes.isEmpty {
                        self.errorMessage = "No recipes found. Try different ingredients."
                    }
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to fetch recipes: \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }
    }
}
