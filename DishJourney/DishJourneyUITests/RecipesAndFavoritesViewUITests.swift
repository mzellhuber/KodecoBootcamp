//
//  RecipesAndFavoritesViewUITests.swift
//  DishJourneyUITests
//
//  Created by Melissa Zellhuber on 19/05/24.
//

import XCTest

class RecipesAndFavoritesViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testAddFavoritesAndCheckDisplay() throws {
        navigateToRecipesTab()

        let searchField = app.textFields["SearchField"]
        XCTAssertTrue(searchField.waitForExistence(timeout: 5), "The search field does not exist")
        searchField.tap()
        searchField.typeText("Pasta\n")

        let fetchRecipesButton = app.buttons["FetchRecipesButton"]
        XCTAssertTrue(fetchRecipesButton.exists, "The fetch recipes button does not exist")
        fetchRecipesButton.tap()

        let firstRecipeRow = app.collectionViews.buttons.containing(NSPredicate(format: "identifier BEGINSWITH 'RecipeRow-'")).firstMatch
        XCTAssertTrue(firstRecipeRow.waitForExistence(timeout: 10), "First recipe does not exist")

        firstRecipeRow.tap()

        app.scrollViews.otherElements.buttons["Love"].tap()
        app.navigationBars["Recipe Details"].buttons["Back"].tap()

        let secondRecipeRow = app.collectionViews.buttons.containing(NSPredicate(format: "identifier BEGINSWITH 'RecipeRow-'")).element(boundBy: 1)
        XCTAssertTrue(secondRecipeRow.waitForExistence(timeout: 10), "Second recipe does not exist")
        secondRecipeRow.tap()

        app.scrollViews.otherElements.buttons["Love"].tap()
        app.navigationBars["Recipe Details"].buttons["Back"].tap()

        navigateToFavoritesTab()

        let favoriteRecipes = app.collectionViews.cells
        XCTAssertTrue(favoriteRecipes.count >= 2, "There should be at least two favorite recipes")
    }

    private func navigateToRecipesTab() {
        let recipesTab = app.buttons["house.fillTabButton"]
        XCTAssertTrue(recipesTab.waitForExistence(timeout: 5), "The recipes tab button does not exist")
        recipesTab.tap()
    }

    private func navigateToFavoritesTab() {
        let favoritesTab = app.buttons["heart.fillTabButton"]
        XCTAssertTrue(favoritesTab.waitForExistence(timeout: 5), "The favorites tab button does not exist")
        favoritesTab.tap()
    }
}
