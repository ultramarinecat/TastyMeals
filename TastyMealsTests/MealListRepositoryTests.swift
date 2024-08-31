//
//  MealListRepositoryTests.swift
//  TastyMealsTests
//

import XCTest

@testable import TastyMeals

// Meal list repository tests.
final class MealListRepositoryTests: XCTestCase {
    private func makeMeals() -> [Meal] {
        [
            Meal(
                id: MealDataStubRepository.meal1ID,
                name: MealDataStubRepository.meal1Name,
                imageURLString: MealDataStubRepository.meal1ImageURLString
            ),
            Meal(
                id: MealDataStubRepository.meal2ID,
                name: MealDataStubRepository.meal2Name,
                imageURLString: MealDataStubRepository.meal2ImageURLString
            )
        ]
    }

    func test_fetchMeals_should_fetchAndReturnMeals() async throws {
        let sut = MealListRepository(dataRepository: MealDataStubRepository())
        let meals = makeMeals()

        let fetchedMeals = try await sut.fetchMeals()
        XCTAssertEqual(fetchedMeals, meals)
    }

    func test_fetchMeals_when_fetchedMealsEmpty_should_throw() async throws {
        let stubDataRepository = MealDataStubRepository(isEmpty: true)
        let sut = MealListRepository(dataRepository: stubDataRepository)

        do {
            _ = try await sut.fetchMeals()
            XCTFail("Expected TastyMealsError.noMeals but no error was thrown.")
        } catch {
            if case TastyMealsError.noMeals = error {
                return
            }
            XCTFail("Unexpected error: \(error)")
        }
    }
}
