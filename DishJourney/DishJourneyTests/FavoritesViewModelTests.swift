//
//  FavoritesViewModelTests.swift
//  DishJourneyTests
//
//  Created by Melissa Zellhuber on 13/05/24.
//

import XCTest
import Combine
@testable import DishJourney

class FavoritesViewModelTests: XCTestCase {
  var viewModel: FavoritesViewModel?
  var cancellables: Set<AnyCancellable> = []

  override func setUp() {
    super.setUp()
    viewModel = FavoritesViewModel()
    cancellables = []
    clearFavorites()
  }

  override func tearDown() {
    viewModel = nil
    cancellables = []
    clearFavorites()
    super.tearDown()
  }

  func testLoadFavorites() {
    guard let viewModel = viewModel else {
      XCTFail("viewModel should not be nil")
      return
    }

    let expectation = XCTestExpectation(description: "Load favorites")

    FavoritesManager.shared.toggleFavorite(recipe: sampleRecipe)

    viewModel.$favorites
      .sink { favorites in
        if favorites.contains(where: { $0.label == self.sampleRecipe.label }) {
          XCTAssertEqual(favorites.first { $0.label == self.sampleRecipe.label }?.label, self.sampleRecipe.label)
          expectation.fulfill()
        }
      }
      .store(in: &cancellables)

    wait(for: [expectation], timeout: 1.0)
  }

  func testToggleFavorite() {
    guard let viewModel = viewModel else {
      XCTFail("viewModel should not be nil")
      return
    }

    viewModel.toggleFavorite(sampleRecipe)
    XCTAssertTrue(viewModel.isFavorite(sampleRecipe))

    viewModel.toggleFavorite(sampleRecipe)
    XCTAssertFalse(viewModel.isFavorite(sampleRecipe))
  }

  private func clearFavorites() {
    let currentFavorites = FavoritesManager.shared.favorites
    currentFavorites.forEach { FavoritesManager.shared.toggleFavorite(recipe: $0) }
  }

  var sampleRecipe: Recipe {
    Recipe(
      uri: "sampleURI",
      label: "Sample Recipe",
      image: "sampleImage",
      source: "sampleSource",
      url: "sampleURL",
      shareAs: "sampleShareAs",
      yield: 1,
      dietLabels: [],
      healthLabels: [],
      cautions: [],
      ingredientLines: [],
      ingredients: [],
      calories: 0.0,
      totalWeight: 0.0,
      totalTime: 0,
      cuisineType: [],
      mealType: [],
      dishType: nil,
      totalNutrients: [:],
      totalDaily: [:],
      digest: [],
      tags: nil
    )
  }
}
