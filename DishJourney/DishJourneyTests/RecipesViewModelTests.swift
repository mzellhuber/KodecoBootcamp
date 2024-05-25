//
//  RecipesViewModelTests.swift
//  DishJourneyTests
//
//  Created by Melissa Zellhuber on 13/05/24.
//

import XCTest
import Combine
@testable import DishJourney

class RecipesViewModelTests: XCTestCase {
  var viewModel: RecipesViewModel?
  var cancellables: Set<AnyCancellable> = []

  override func setUp() {
    super.setUp()
    viewModel = RecipesViewModel()
    cancellables = []
  }

  override func tearDown() {
    viewModel = nil
    cancellables = []
    super.tearDown()
  }

  func testAddIngredient() {
    guard let viewModel = viewModel else {
      XCTFail("viewModel should not be nil")
      return
    }

    viewModel.ingredient = "Tomato"
    viewModel.addIngredient()

    XCTAssertEqual(viewModel.ingredients, ["Tomato"])
  }

  func testFetchRecipes() {
    guard let viewModel = viewModel else {
      XCTFail("viewModel should not be nil")
      return
    }

    let expectation = XCTestExpectation(description: "Fetch recipes")

    viewModel.ingredients = ["Tomato"]

    viewModel.$recipes
      .dropFirst()
      .sink { recipes in
        XCTAssertFalse(recipes.isEmpty)
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.fetchRecipes()

    wait(for: [expectation], timeout: 5.0)
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
