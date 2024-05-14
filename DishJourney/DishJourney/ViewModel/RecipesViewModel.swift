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
    @Published var canLoadMoreContent = true
    
    private var cancellables = Set<AnyCancellable>()
    
    private var currentPage = 0
    private var pageSize = 20
    
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
        guard canLoadMoreContent && !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        let fromIndex = currentPage * pageSize
        let toIndex = fromIndex + pageSize
        
        Task {
            do {
                let apiService = ApiService()
                let fetchedRecipes = try await apiService.fetchRecipes(query: ingredients.joined(separator: ", "), from: fromIndex, to: toIndex)
                DispatchQueue.main.async {
                    self.recipes.append(contentsOf: fetchedRecipes)
                    self.currentPage += 1
                    self.isLoading = false
                    self.canLoadMoreContent = true
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to fetch recipes: \(error.localizedDescription)"
                    self.isLoading = false
                    self.canLoadMoreContent = true
                }
            }
        }
    }
}
