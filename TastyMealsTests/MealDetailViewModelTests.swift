//
//  MealDetailViewModelTests.swift
//  TastyMealsTests
//

import XCTest

@testable import TastyMeals

/// Meal detail view model tests.
final class MealDetailViewModelTests: XCTestCase {
    private let meal = Meal(
        id: "2",
        name: "meal",
        imageURLString: "meal.jpg"
    )

    @MainActor
    func test_when_viewWillAppear_should_fetchAndSetMeal() async throws {
        let repository = makeRepository()
        let sut = MealDetailViewModel(repository: repository)
        let mealID = "1"

        let meal = try await repository.fetchMeal(for: mealID)
        XCTAssertNil(sut.meal)

        await sut.handleViewWillAppear(for: mealID)
        XCTAssertEqual(sut.meal, meal)
    }

    @MainActor
    func test_given_fetchUnsuccesful_when_viewWillAppear_should_displayErrorMessage() async throws {
        let repository = makeRepository(isSuccessful: false)
        let sut = MealDetailViewModel(repository: repository)
        XCTAssertNil(sut.errorMessage)

        await sut.handleViewWillAppear(for: meal.id)
        XCTAssertNotNil(sut.errorMessage)
    }

    @MainActor
    func test_given_hasPreviousMeal_when_viewWillAppear_should_clearPreviousMeal() async throws {
        let repository = makeRepository()
        let sut = MealDetailViewModel(repository: repository)
        let previousMealID = "1"
        let previousMeal = try await repository.fetchMeal(for: previousMealID)

        await sut.handleViewWillAppear(for: previousMealID)
        XCTAssertEqual(sut.meal, previousMeal)

        await sut.handleViewWillAppear(for: meal.id)
        XCTAssertNotEqual(sut.meal, previousMeal)
    }

    private func makeRepository(isSuccessful: Bool = true) -> MealDetailRepositoryProtocol {
        let stubDataRepository = MealDataStubRepository(isSuccessful: isSuccessful)
        return MealDetailRepository(dataRepository: stubDataRepository)
    }
}
