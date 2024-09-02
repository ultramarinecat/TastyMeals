//
//  MealDetailRepositoryTests.swift
//  TastyMealsTests
//

import XCTest

@testable import TastyMeals

/// Meal detail repository tests.
final class MealDetailRepositoryTests: XCTestCase {
    private let meal = Meal(
        id: "1",
        name: MealDataStubRepository.mealName,
        imageURLString: MealDataStubRepository.mealImageURLString,
        instructions: MealDataStubRepository.mealInstructions,
        ingredient1: MealDataStubRepository.mealIngredient1,
        ingredient2: MealDataStubRepository.mealIngredient2,
        measurement1: MealDataStubRepository.mealMeasurement1,
        measurement2: MealDataStubRepository.mealMeasurement2
    )

    func test_fetchMeal_should_fetchAndReturnMeal() async throws {
        let sut = MealDetailRepository(dataRepository: MealDataStubRepository())
        let fetchedMeal = try await sut.fetchMeal(for: meal.id)

        XCTAssertEqual(fetchedMeal, meal)
    }

    func test_fetchMeal_when_fetchedMealEmpty_should_throw() async throws {
        let stubDataRepository = MealDataStubRepository(isEmpty: true)
        let sut = MealDetailRepository(dataRepository: stubDataRepository)
        let mealID = "1"

        do {
            _ = try await sut.fetchMeal(for: mealID)
            XCTFail("Expected TastyMealsError.noMealDetails but no error was thrown")
        } catch {
            if case TastyMealsError.noMealDetails(let id) = error, id == mealID {
                return
            }
            XCTFail("Unexpected error: \(error)")
        }
    }
}
