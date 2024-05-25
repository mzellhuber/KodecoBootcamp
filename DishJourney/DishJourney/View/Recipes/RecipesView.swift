//
//  RecipesView.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 02/05/24.
//

import SwiftUI

struct RecipesView: View {
  @StateObject private var viewModel = RecipesViewModel()

  var body: some View {
    NavigationView {
      VStack {
        ClearableTextField("Enter ingredients", text: $viewModel.ingredient) {
          viewModel.addIngredient()
        }
        .padding()
        .accessibilityIdentifier("SearchField")

        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
            ForEach(viewModel.ingredients, id: \.self) { item in
              TagView(tag: item) {
                withAnimation(.spring()) {
                  if let index = viewModel.ingredients.firstIndex(of: item) {
                    viewModel.ingredients.remove(at: index)
                  }
                }
              }
            }
            .transition(.scale)
          }
          .padding(.horizontal)
        }

        Button("Fetch Recipes") {
          if !viewModel.ingredient.isEmpty && !viewModel.ingredients.contains(viewModel.ingredient) {
            withAnimation(.spring()) {
              viewModel.ingredients.append(viewModel.ingredient)
              viewModel.ingredient = ""
            }
          }

          if !viewModel.ingredients.isEmpty {
            viewModel.fetchRecipes()
            viewModel.showIngredientWarning = false
          } else {
            withAnimation(.spring()) {
              viewModel.showIngredientWarning = true
            }
          }
        }
        .buttonStyle(GradientBackgroundButtonStyle())
        .padding(.horizontal, 8)
        .accessibilityIdentifier("FetchRecipesButton")

        if viewModel.showIngredientWarning {
          Text("Please add at least one ingredient to fetch recipes.")
            .foregroundColor(.red)
            .padding()
            .transition(.opacity.animation(.spring()))
        }

        ZStack {
          recipeList
          if viewModel.isLoading {
            ProgressView()
              .opacity(viewModel.isLoading ? 1 : 0)
          }
        }

        if let errorMessage = viewModel.errorMessage {
          Text(errorMessage)
            .foregroundColor(.red)
            .transition(.opacity.animation(.spring()))
        }
      }
    }
  }

  private var recipeList: some View {
    List {
      ForEach(viewModel.recipes, id: \.uri) { recipe in
        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
          RecipeRow(recipe: recipe)
            .accessibilityIdentifier("RecipeRow-\(recipe.uri)")
        }
      }
      if viewModel.canLoadMoreContent {
        Text("Loading more recipes...")
          .foregroundColor(.clear)
          .frame(maxHeight: 0)
          .onAppear {
            if !viewModel.ingredients.isEmpty {
              viewModel.fetchRecipes()
            }
          }
      }
    }
    .listStyle(PlainListStyle())
  }
}

extension View {
  func onReachBottom(perform action: @escaping () -> Void) -> some View {
    self.onAppear {
      NotificationCenter.default.addObserver(
        forName: NSNotification.Name("onScroll"),
        object: nil,
        queue: .main) { _ in
        let scrollView = UIScrollView.appearance()
        let offset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if contentHeight - offset < scrollView.frame.size.height * 2 {
          action()
        }
      }
    }
  }
}

struct GradientBackgroundButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .frame(maxWidth: .infinity)
      .background(LinearGradient(
        gradient: Gradient(colors: [Color.blue, Color.purple]),
        startPoint: .leading,
        endPoint: .trailing))
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
