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

    func test_should_fetchAndReturnMeals() async throws {
        let sut = MealListRepository(dataRepository: MealDataStubRepository())
        let meals = makeMeals()

        let fetchedMeals = try await sut.fetchMeals()
        XCTAssertEqual(fetchedMeals, meals)
    }

    func test_given_fetchedMealsEmpty_should_throw() async throws {
        let stubDataRepository = MealDataStubRepository(isEmpty: true)
        let sut = MealListRepository(dataRepository: stubDataRepository)

        do {
            _ = try await sut.fetchMeals()
            XCTFail("Should throw no meals error on empty fetched meals")
        } catch {
            if case TastyMealsError.noMeals = error {
                return
            }
            XCTFail("Unexpected error thrown on empty fetched meals")
        }
    }
}
