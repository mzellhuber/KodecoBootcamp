//
//  MealPlannerUITests.swift
//  DishJourneyUITests
//
//  Created by Melissa Zellhuber on 18/05/24.
//

import XCTest

class MealPlannerViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func scrollToElement(_ element: XCUIElement) {
        app.swipeUp(velocity: .fast)
        app.swipeUp(velocity: .fast)
    }

    func testMealPlanCreation() {
        navigateToMealPlannerTab()

        let createMealPlanButton = app.buttons["CreateMealPlanButton"]
        scrollToElement(createMealPlanButton)

        XCTAssertTrue(createMealPlanButton.exists)
        createMealPlanButton.tap()

        scrollToElement(createMealPlanButton)

        verifyMealPlanExists()
    }

    func testNoMealPlan() {
        navigateToMealPlannerTab()

        let createMealPlanButton = app.buttons["CreateMealPlanButton"]
        scrollToElement(createMealPlanButton)

        let noMealPlanErrorText = app.staticTexts["No meal plan available. Please create one."]
        XCTAssertTrue(noMealPlanErrorText.waitForExistence(timeout: 5), "No meal plan error text is not visible")
    }

    private func navigateToMealPlannerTab() {
        let mealPlannerTab = app.buttons["calendarTabButton"]
        XCTAssertTrue(mealPlannerTab.waitForExistence(timeout: 5), "The meal planner tab button does not exist")
        mealPlannerTab.tap()
    }

    private func verifyMealPlanExists() {
        let dayDisclosureGroup = app.staticTexts["Day 1"]
        XCTAssertTrue(dayDisclosureGroup.waitForExistence(timeout: 2), "Day 1 disclosure group does not exist")
    }
}
