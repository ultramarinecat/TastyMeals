//
//  MealDetailRepositoryTests.swift
//  TastyMealsTests
//

import XCTest

@testable import TastyMeals

/// Meal detail repository tests.
final class MealDetailRepositoryTests: XCTestCase {
    private func makeMeal() -> Meal {
        Meal(
            id: "1",
            name: MealDataStubRepository.mealName,
            imageURLString: MealDataStubRepository.mealImageURLString,
            instructions: MealDataStubRepository.mealInstructions,
            ingredient1: MealDataStubRepository.mealIngredient1,
            ingredient2: MealDataStubRepository.mealIngredient2,
            measurement1: MealDataStubRepository.mealMeasurement1,
            measurement2: MealDataStubRepository.mealMeasurement2
        )
    }

    func test_should_fetchAndReturnMeal() async throws {
        let sut = MealDetailRepository(dataRepository: MealDataStubRepository())
        let meal = makeMeal()

        let fetchedMeal = try await sut.fetchMeal(for: meal.id)
        XCTAssertEqual(fetchedMeal, meal)
    }

    func test_given_fetchedMealEmpty_should_throw() async throws {
        let stubDataRepository = MealDataStubRepository(isEmpty: true)
        let sut = MealDetailRepository(dataRepository: stubDataRepository)
        let mealID = "1"

        do {
            _ = try await sut.fetchMeal(for: mealID)
            XCTFail("Should throw no meal details error on empty fetched meal")
        } catch {
            if case TastyMealsError.noMealDetails(let id) = error, id == mealID {
                return
            }
            XCTFail("Unexpected error thrown on empty fetched meal")
        }
    }
}
