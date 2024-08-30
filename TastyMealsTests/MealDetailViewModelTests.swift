//
//  MealDetailViewModelTests.swift
//  TastyMealsTests
//

import XCTest

@testable import TastyMeals

/// Meal detail view model tests.
final class MealDetailViewModelTests: XCTestCase {
    @MainActor
    private func makeSUT(meal: Meal? = nil, isSuccessful: Bool = true) async -> MealDetailViewModel {
        let stubDataRepository = MealDataStubRepository(isSuccessful: isSuccessful)
        let repository = MealDetailRepository(dataRepository: stubDataRepository)
        let sut = MealDetailViewModel(repository: repository)

        if let meal {
            await sut.handleViewWillAppear(with: meal)
        }
        return sut
    }

    private func makeMeal(mealID: String = "1") -> Meal {
        Meal(
            id: mealID,
            name: MealDataStubRepository.mealName,
            imageURLString: MealDataStubRepository.mealImageURLString,
            instructions: MealDataStubRepository.mealInstructions,
            ingredient1: MealDataStubRepository.mealIngredient1,
            ingredient2: MealDataStubRepository.mealIngredient2,
            measurement1: MealDataStubRepository.mealMeasurement1,
            measurement2: MealDataStubRepository.mealMeasurement2
        )
    }

    @MainActor
    func test_when_viewWillAppear_should_fetchAndSetMeal() async throws {
        let meal = makeMeal()
        let sut = await makeSUT()
        XCTAssertNil(sut.meal)

        await sut.handleViewWillAppear(with: meal)
        XCTAssertEqual(sut.meal, meal)
    }

    @MainActor
    func test_given_fetchUnsuccesful_when_viewWillAppear_should_displayErrorMessage() async throws {
        let meal = makeMeal()
        let sut = await makeSUT(isSuccessful: false)

        XCTAssertNil(sut.errorMessage)
        await sut.handleViewWillAppear(with: meal)
        XCTAssertNotNil(sut.errorMessage)
    }

    @MainActor
    func test_given_hasPreviousMeal_when_viewWillAppear_should_clearPreviousMeal() async throws {
        let meal1 = makeMeal(mealID: "1")
        let meal2 = makeMeal(mealID: "2")
        let sut = await makeSUT(meal: meal1)

        await sut.handleViewWillAppear(with: meal1)
        XCTAssertEqual(sut.meal, meal1)

        await sut.handleViewWillAppear(with: meal2)
        XCTAssertNotEqual(sut.meal, meal1)
        XCTAssertEqual(sut.meal, meal2)
    }
}
