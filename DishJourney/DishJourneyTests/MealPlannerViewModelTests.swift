//
//  MealPlannerViewModelTests.swift
//  DishJourneyTests
//
//  Created by Melissa Zellhuber on 13/05/24.
//

import XCTest
import Combine
@testable import DishJourney

class MealPlannerViewModelTests: XCTestCase {
  var viewModel: MealPlannerViewModel?
  var cancellables: Set<AnyCancellable> = []

  override func setUp() {
    super.setUp()
    viewModel = MealPlannerViewModel(apiService: MockApiService())
    cancellables = []
  }

  override func tearDown() {
    viewModel = nil
    cancellables = []
    super.tearDown()
  }

  func testFetchMealPlanSuccess() {
    guard let viewModel = viewModel else {
      XCTFail("viewModel should not be nil")
      return
    }

    let expectation = XCTestExpectation(description: "Fetch meal plan successfully")

    viewModel.$mealPlan
      .dropFirst()
      .sink { mealPlan in
        XCTAssertNotNil(mealPlan)
        XCTAssertEqual(mealPlan?.count, 9)
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.fetchMealPlan()

    wait(for: [expectation], timeout: 5.0)
  }

  func testFetchMealPlanFailure() {
    guard let viewModel = viewModel else {
      XCTFail("viewModel should not be nil")
      return
    }

    let expectation = XCTestExpectation(description: "Fetch meal plan failure")

    (viewModel.apiService as? MockApiService)?.shouldReturnError = true

    viewModel.$noResults
      .dropFirst()
      .sink { noResults in
        XCTAssertTrue(noResults)
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.fetchMealPlan()

    wait(for: [expectation], timeout: 5.0)
  }

  func testDistributeRecipes() {
    guard let viewModel = viewModel else {
      XCTFail("viewModel should not be nil")
      return
    }

    let sampleRecipes = [
      sampleRecipe(day: 0, mealType: .breakfast),
      sampleRecipe(day: 0, mealType: .lunch),
      sampleRecipe(day: 0, mealType: .dinner)
    ]

    let distributedRecipes = viewModel.distributeRecipes(allRecipes: sampleRecipes)

    XCTAssertEqual(distributedRecipes.count, sampleRecipes.count)
    XCTAssertEqual(distributedRecipes[0].day, 0)
    XCTAssertEqual(distributedRecipes[0].mealType, [.breakfast])
    XCTAssertEqual(distributedRecipes[1].day, 0)
    XCTAssertEqual(distributedRecipes[1].mealType, [.lunch])
    XCTAssertEqual(distributedRecipes[2].day, 0)
    XCTAssertEqual(distributedRecipes[2].mealType, [.dinner])
  }

  private func sampleRecipe(day: Int, mealType: MealType) -> Recipe {
    Recipe(
      uri: "sampleURI-\(day)-\(mealType.rawValue)",
      label: "Sample Recipe \(day) \(mealType.rawValue)",
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
      mealType: [mealType],
      dishType: nil,
      totalNutrients: [:],
      totalDaily: [:],
      digest: [],
      tags: nil
    )
  }
}

class MockApiService: ApiService {
  var shouldReturnError = false
  var mockRecipes: [Recipe] = []

  override func createMealPlan(
    request: MealPlanRequest
  ) async throws -> [Recipe] {
    if shouldReturnError {
      throw NSError(domain: "TestError", code: 1, userInfo: nil)
    }
    return mockRecipes.isEmpty ? createSampleRecipes() : mockRecipes
  }

  private func createSampleRecipes() -> [Recipe] {
    return [
      createSampleRecipe(forMealType: .breakfast),
      createSampleRecipe(forMealType: .lunch),
      createSampleRecipe(forMealType: .dinner)
    ]
  }

  private func createSampleRecipe(forMealType mealType: MealType) -> Recipe {
    return Recipe(
      uri: "sampleURI-0-\(mealType.rawValue)",
      label: "Sample Recipe 0 \(mealType.rawValue)",
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
      mealType: [mealType],
      dishType: nil,
      totalNutrients: [:],
      totalDaily: [:],
      digest: [],
      tags: nil
    )
  }
}
