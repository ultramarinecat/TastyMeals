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

    private func makeRepository(isSuccessful: Bool = true) -> MealDetailRepositoryProtocol {
        let stubDataRepository = MealDataStubRepository(isSuccessful: isSuccessful)
        return MealDetailRepository(dataRepository: stubDataRepository)
    }

    @MainActor
    func test_when_viewWillAppear_should_fetchAndSetMeal() async throws {
        let repository = makeRepository()
        let sut = MealDetailViewModel(repository: repository)

        let meal = try await repository.fetchMeal(for: "1")
        XCTAssertNil(sut.meal)

        await sut.handleViewWillAppear(with: meal)
        XCTAssertEqual(sut.meal, meal)
    }

    @MainActor
    func test_given_fetchUnsuccesful_when_viewWillAppear_should_displayErrorMessage() async throws {
        let repository = makeRepository(isSuccessful: false)
        let sut = MealDetailViewModel(repository: repository)
        XCTAssertNil(sut.errorMessage)

        await sut.handleViewWillAppear(with: meal)
        XCTAssertNotNil(sut.errorMessage)
    }

    @MainActor
    func test_given_hasPreviousMeal_when_viewWillAppear_should_clearPreviousMeal() async throws {
        let repository = makeRepository()
        let sut = MealDetailViewModel(repository: repository)
        let previousMeal = try await repository.fetchMeal(for: "1")

        await sut.handleViewWillAppear(with: previousMeal)
        XCTAssertEqual(sut.meal, previousMeal)

        await sut.handleViewWillAppear(with: meal)
        XCTAssertNotEqual(sut.meal, previousMeal)
    }
}
