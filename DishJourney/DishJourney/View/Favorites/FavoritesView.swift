//
//  FavoritesView.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 12/05/24.
//

import SwiftUI

struct FavoritesView: View {
  @StateObject var viewModel = FavoritesViewModel()

  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.favorites, id: \.uri) { recipe in
          NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
            RecipeRow(recipe: recipe)
          }
        }
        .onDelete(perform: viewModel.removeFavorites)
      }
      .navigationTitle("Favorites")
      .toolbar {
        EditButton()
      }
    }
  }
}

#Preview {
  FavoritesView()
}
