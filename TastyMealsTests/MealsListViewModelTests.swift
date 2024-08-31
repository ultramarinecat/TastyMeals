//
//  MealsListViewModelTests.swift
//  TastyMealsTests
//

import XCTest

@testable import TastyMeals

/// Meal list view model tests.
final class MealsListViewModelTests: XCTestCase {
    private func makeRepository(isSuccessful: Bool = true, isOrderedByName: Bool = true) -> MealListRepositoryProtocol {
        let stubDataRepository = MealDataStubRepository(isSuccessful: isSuccessful, isOrderedByName: isOrderedByName)
        return MealListRepository(dataRepository: stubDataRepository)
    }

    private func isSorted(meals: [Meal]) -> Bool {
        zip(meals, meals.dropFirst()).allSatisfy { $0.name <= $1.name }
    }

    @MainActor
    func test_when_viewWillAppear_should_fetchAndSetMeals() async throws {
        let repository = makeRepository()
        let sut = MealListViewModel(repository: repository)

        let expectedMeals = try await repository.fetchMeals()
        XCTAssertNil(sut.meals)

        await sut.handleViewWillAppear()
        XCTAssertEqual(sut.meals, expectedMeals)
    }

    @MainActor
    func test_when_refreshButtonTapped_should_fetchAndSetMeals() async throws {
        let repository = makeRepository()
        let sut = MealListViewModel(repository: repository)

        let expectedMeals = try await repository.fetchMeals()
        XCTAssertNil(sut.meals)

        await sut.handleRefreshButtonTap()
        XCTAssertEqual(sut.meals, expectedMeals)
    }

    @MainActor
    func test_given_fetchUnsuccesful_when_viewWillAppear_should_displayErrorMessage() async throws {
        let repository = makeRepository(isSuccessful: false)
        let sut = MealListViewModel(repository: repository)
        XCTAssertNil(sut.errorMessage)

        await sut.handleViewWillAppear()
        XCTAssertNotNil(sut.errorMessage)
    }

    @MainActor
    func test_given_fetchUnsuccesful_when_refreshButtonTapped_should_displayErrorMessage() async throws {
        let repository = makeRepository(isSuccessful: false)
        let sut = MealListViewModel(repository: repository)
        XCTAssertNil(sut.errorMessage)

        await sut.handleRefreshButtonTap()
        XCTAssertNotNil(sut.errorMessage)
    }

    @MainActor
    func test_when_viewWillAppear_should_setMealsInAlphabeticalOrderByName() async throws {
        let repository = makeRepository(isOrderedByName: false)
        let sut = MealListViewModel(repository: repository)

        await sut.handleViewWillAppear()
        XCTAssertTrue(isSorted(meals: try XCTUnwrap(sut.meals)))
    }
}
