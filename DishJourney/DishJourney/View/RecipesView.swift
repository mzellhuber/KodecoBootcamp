//
//  RecipesView.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 02/05/24.
//

import SwiftUI

struct RecipesView: View {
    @State private var recipes = [Recipe]()
    @State private var ingredient = ""
    @State private var ingredients = [String]()
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var showIngredientWarning = false

    var body: some View {
        VStack {
            ClearableTextField("Enter ingredients", text: $ingredient, onCommit: {
                addIngredient()
            })
            .padding()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(ingredients, id: \.self) { item in
                        TagView(tag: item) {
                            if let index = ingredients.firstIndex(of: item) {
                                ingredients.remove(at: index)
                            }
                        }
                    }
                }.padding(.horizontal)
            }

            Button("Fetch Recipes") {
                if !ingredient.isEmpty && !ingredients.contains(ingredient) {
                    ingredients.append(ingredient)
                    ingredient = ""
                }
                
                if !ingredients.isEmpty {
                    fetchRecipes()
                    showIngredientWarning = false
                } else {
                    showIngredientWarning = true
                }
            }
            .buttonStyle(GradientBackgroundButtonStyle())
            .padding(.horizontal, 8)

            if showIngredientWarning {
                Text("Please add at least one ingredient to fetch recipes.")
                    .foregroundColor(.red)
                    .padding()
            }

            ZStack {
                recipeList
                if isLoading {
                    ProgressView()
                        .opacity(isLoading ? 1 : 0)
                }
            }

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
    }

    private var recipeList: some View {
        List(recipes, id: \.uri) { recipe in
            HStack {
                AsyncImage(url: URL(string: recipe.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading) {
                    Text(recipe.label).font(.headline)
                    Text(recipe.source).font(.subheadline)
                }
                .padding(.leading, 8)
            }
        }
        .listStyle(PlainListStyle())
    }

    private func addIngredient() {
        let cleanedIngredient = ingredient.trimmingCharacters(in: .whitespacesAndNewlines)
        if !cleanedIngredient.isEmpty && !ingredients.contains(cleanedIngredient) {
            ingredients.append(cleanedIngredient)
            ingredient = ""
        }
    }

    private func fetchRecipes() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                let apiService = ApiService()
                let fetchedRecipes = try await apiService.fetchRecipes(query: ingredients.joined(separator: ", "))
                recipes = fetchedRecipes
                if recipes.isEmpty {
                    errorMessage = "No recipes found. Try different ingredients."
                }
            } catch {
                errorMessage = "Failed to fetch recipes: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
}

struct GradientBackgroundButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
            .foregroundColor(.white)
            .cornerRadius(40)
            .shadow(radius: 5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
