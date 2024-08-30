//
//  MealsListViewModelTests.swift
//  TastyMealsTests
//

import XCTest

@testable import TastyMeals

/// Meal list view model tests.
final class MealsListViewModelTests: XCTestCase {
    private func makeSUT(isSuccessful: Bool = true, isOrderedByName: Bool = true) async -> MealListViewModel {
        let stubDataRepository = MealDataStubRepository(isSuccessful: isSuccessful, isOrderedByName: isOrderedByName)
        let repository = MealListRepository(dataRepository: stubDataRepository)

        return MealListViewModel(repository: repository)
    }

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

    private func isSorted(meals: [Meal]) -> Bool {
        zip(meals, meals.dropFirst()).allSatisfy { $0.name <= $1.name }
    }

    @MainActor
    func test_when_viewWillAppear_should_fetchAndSetMeals() async throws {
        let meals = makeMeals()
        let sut = await makeSUT()
        XCTAssertNil(sut.meals)

        await sut.handleViewWillAppear()
        XCTAssertEqual(sut.meals, meals)
    }

    @MainActor
    func test_when_refreshButtonTapped_should_fetchAndSetMeals() async throws {
        let meals = makeMeals()
        let sut = await makeSUT()
        XCTAssertNil(sut.meals)

        await sut.handleRefreshButtonTap()
        XCTAssertEqual(sut.meals, meals)
    }

    @MainActor
    func test_given_fetchUnsuccesful_when_viewWillAppear_should_displayErrorMessage() async throws {
        let sut = await makeSUT(isSuccessful: false)
        XCTAssertNil(sut.errorMessage)

        await sut.handleViewWillAppear()
        XCTAssertNotNil(sut.errorMessage)
    }

    @MainActor
    func test_given_fetchUnsuccesful_when_refreshButtonTapped_should_displayErrorMessage() async throws {
        let sut = await makeSUT(isSuccessful: false)
        XCTAssertNil(sut.errorMessage)

        await sut.handleRefreshButtonTap()
        XCTAssertNotNil(sut.errorMessage)
    }

    @MainActor
    func test_when_viewWillAppear_should_setMealsInAlphabeticalOrderByName() async throws {
        let sut = await makeSUT(isOrderedByName: false)

        await sut.handleViewWillAppear()
        XCTAssertTrue(isSorted(meals: try XCTUnwrap(sut.meals)))
    }
}
