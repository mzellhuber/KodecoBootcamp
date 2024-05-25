//
//  MealPlannerViewModel.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 13/05/24.
//

import Combine
import SwiftUI

class MealPlannerViewModel: ObservableObject {
  @Published var numberOfDays: Int = 7
  @Published var selectedDietLabel: DietLabel = .balanced
  @Published var selectedHealthLabels: [HealthLabel] = []
  @Published var calorieMinString: String = "1200"
  @Published var calorieMaxString: String = "1800"

  var calorieRange: (min: Int, max: Int) {
    get {
      (min: Int(calorieMinString) ?? 1200, max: Int(calorieMaxString) ?? 1800)
    }
    set {
      calorieMinString = "\(newValue.min)"
      calorieMaxString = "\(newValue.max)"
    }
  }

  @Published var selectedMealTypes: [MealType] = [.breakfast, .lunch, .dinner]
  @Published var mealPlan: [Recipe]?
  @Published var noResults = false

  var apiService: ApiService

  init(apiService: ApiService = ApiService()) {
    self.apiService = apiService
  }

  func fetchMealPlan() {
    Task {
      do {
        var allRecipes: [Recipe] = []
        // Fetch recipes for each meal type separately
        for mealType in selectedMealTypes {
          let mealPlanRequest = MealPlanRequest(
            query: "",
            size: numberOfDays,
            dietLabels: [selectedDietLabel.rawValue.lowercased()],
            healthLabels: selectedHealthLabels.map { $0.rawValue.lowercased() },
            mealType: mealType.rawValue.lowercased(),
            calorieMin: calorieRange.min,
            calorieMax: calorieRange.max
          )
          let recipes = try await apiService.createMealPlan(request: mealPlanRequest)
          allRecipes.append(contentsOf: recipes)
        }

        let distributedRecipes = distributeRecipes(allRecipes: allRecipes)
        DispatchQueue.main.async {
          self.mealPlan = distributedRecipes
          self.noResults = distributedRecipes.isEmpty
        }
      } catch {
        DispatchQueue.main.async {
          print("Error fetching meal plan: \(error)")
          self.noResults = true
        }
      }
    }
  }

  func distributeRecipes(allRecipes: [Recipe]) -> [Recipe] {
    var distributedRecipes: [Recipe] = []
    for day in 0..<numberOfDays {
      for (index, mealType) in selectedMealTypes.enumerated() {
        let recipeIndex = (day * selectedMealTypes.count) + index
        if recipeIndex < allRecipes.count {
          var recipe = allRecipes[recipeIndex]
          recipe.day = day
          recipe.mealType = [mealType]
          distributedRecipes.append(recipe)
        }
      }
    }
    return distributedRecipes
  }
}
