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
      VStack {
        if viewModel.favorites.isEmpty {
          emptyStateView
        } else {
          favoritesListView
        }
      }
      .navigationTitle("Favorites")
      .toolbar {
        EditButton()
      }
    }
  }

  private var emptyStateView: some View {
    VStack {
      Image(systemName: "heart")
        .resizable()
        .frame(width: 100, height: 100)
        .foregroundColor(.gray)
        .padding()
      Text("No Favorites Yet")
        .font(.title)
        .foregroundColor(.gray)
      Text("You can add recipes to your favorites by tapping the heart icon on the recipe row or detail page.")
        .font(.body)
        .foregroundColor(.gray)
        .multilineTextAlignment(.center)
        .padding(.horizontal)
    }
    .padding()
  }

  private var favoritesListView: some View {
    List {
      ForEach(viewModel.favorites, id: \.uri) { recipe in
        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
          RecipeRow(recipe: recipe)
        }
      }
      .onDelete(perform: viewModel.removeFavorites)
    }
  }
}

#Preview {
  FavoritesView()
}
