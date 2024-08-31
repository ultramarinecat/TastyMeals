//
//  MealIngredientsViewModelTests.swift
//  TastyMealsTests
//

import XCTest

@testable import TastyMeals

/// Meal ingredients view model tests.
final class MealIngredientsViewModelTests: XCTestCase {
    private let ingredient1 = "ingredient 1"
    private let ingredient2 = "ingredient 2"
    private let measurement1 = "measurement 1"
    private let measurement2 = "measurement 2"

    @MainActor
    private func makeSUT(
        ingredient1: String? = nil,
        ingredient2: String? = nil,
        measurement1: String? = nil,
        measurement2: String? = nil
    ) -> MealIngredientsViewModel {
        let sut = MealIngredientsViewModel()
        let meal = Meal(
            id: "1",
            name: "meal",
            imageURLString: "meal.jpg",
            ingredient1: ingredient1,
            ingredient2: ingredient2,
            measurement1: measurement1,
            measurement2: measurement2
        )

        XCTAssertTrue((sut.ingredients ?? []).isEmpty)
        sut.handleViewWillAppear(with: meal)
        return sut
    }

    @MainActor
    func test_when_viewWillAppear_should_setIngredientsFromMeal() throws {
        let sut = makeSUT(
            ingredient1: ingredient1,
            ingredient2: ingredient2,
            measurement1: measurement1,
            measurement2: measurement2
        )

        let sutIngredients = try XCTUnwrap(sut.ingredients)
        XCTAssertEqual(sutIngredients.count, 2)

        let sutIngredient1 = sutIngredients[0]
        XCTAssertEqual(sutIngredient1.name, ingredient1)
        XCTAssertEqual(sutIngredient1.measurement, measurement1)

        let sutIngredient2 = sutIngredients[1]
        XCTAssertEqual(sutIngredient2.measurement, measurement2)
    }

    @MainActor
    func test_given_ingredientWithoutMeasurement_when_viewWillAppear_should_notIncludeInIngredients() throws {
        let sut = makeSUT(
            ingredient1: ingredient1,
            ingredient2: ingredient2,
            measurement1: measurement1
        )

        let sutIngredients = try XCTUnwrap(sut.ingredients)
        XCTAssertEqual(sutIngredients.count, 1)

        let sutIngredient1 = sutIngredients[0]
        XCTAssertEqual(sutIngredient1.name, ingredient1)
        XCTAssertEqual(sutIngredient1.measurement, measurement1)
    }

    @MainActor
    func test_given_measurementWithoutIngredient_when_viewWillAppear_should_notIncludeInIngredients() throws {
        let sut = makeSUT(
            ingredient1: ingredient1,
            measurement1: measurement1,
            measurement2: measurement2
        )

        let sutIngredients = try XCTUnwrap(sut.ingredients)
        XCTAssertEqual(sutIngredients.count, 1)

        let sutIngredient1 = sutIngredients[0]
        XCTAssertEqual(sutIngredient1.name, ingredient1)
        XCTAssertEqual(sutIngredient1.measurement, measurement1)
    }

    @MainActor
    func test_given_emptyIngredient_when_viewWillAppear_should_notIncludeInIngredients() throws {
        let sut = makeSUT(
            ingredient1: ingredient1,
            ingredient2: "",
            measurement1: measurement1,
            measurement2: measurement2
        )

        let sutIngredients = try XCTUnwrap(sut.ingredients)
        XCTAssertEqual(sutIngredients.count, 1)

        let sutIngredient1 = sutIngredients[0]
        XCTAssertEqual(sutIngredient1.name, ingredient1)
        XCTAssertEqual(sutIngredient1.measurement, measurement1)
    }

    @MainActor
    func test_given_emptyMeasurement_when_viewWillAppear_should_notIncludeInIngredients() throws {
        let sut = makeSUT(
            ingredient1: ingredient1,
            ingredient2: ingredient2,
            measurement1: measurement1,
            measurement2: ""
        )

        let sutIngredients = try XCTUnwrap(sut.ingredients)
        XCTAssertEqual(sutIngredients.count, 1)

        let sutIngredient1 = sutIngredients[0]
        XCTAssertEqual(sutIngredient1.name, ingredient1)
        XCTAssertEqual(sutIngredient1.measurement, measurement1)
    }
}
