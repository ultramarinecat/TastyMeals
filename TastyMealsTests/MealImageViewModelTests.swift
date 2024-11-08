//
//  MealImageViewModelTests.swift
//  TastyMealsTests
//

import XCTest

@testable import TastyMeals

/// Meal image view model tests.
final class MealImageViewModelTests: XCTestCase {
    private let meal = Meal(
        id: "1",
        name: "meal",
        imageURLString: "meal.jpg"
    )

    @MainActor
    func test_given_isPreview_when_viewWillAppear_should_fetchAndSetMealPreviewImageData() async throws {
        let stubRepository = MealDataStubRepository()
        let sut = MealImageViewModel(dataRepository: stubRepository)

        XCTAssertNil(sut.imageDataURL)
        await sut.handleViewWillAppear(with: meal, isPreview: true)

        let expectedURL = try await stubRepository.fetchMealImageDataURL(urlString: meal.imagePreviewURLString)
        XCTAssertEqual(sut.imageDataURL, expectedURL)
    }

    @MainActor
    func test_given_isNotPreview_when_viewWillAppear_should_fetchAndSetMealImageData() async throws {
        let stubRepository = MealDataStubRepository()
        let sut = makeSUT(dataRepository: stubRepository)

        XCTAssertNil(sut.imageDataURL)
        await sut.handleViewWillAppear(with: meal, isPreview: false)

        let expectedURL = try await stubRepository.fetchMealImageDataURL(urlString: meal.imageURLString)
        XCTAssertEqual(sut.imageDataURL, expectedURL)
    }

    @MainActor
    func test_when_viewWillAppear_should_setMealImageDescription() async throws {
        let sut = makeSUT()
        XCTAssertNil(sut.imageDescription)

        await sut.handleViewWillAppear(with: meal, isPreview: false)
        XCTAssertEqual(sut.imageDescription, meal.name)
    }

    @MainActor
    private func makeSUT(dataRepository: MealDataRepository = MealDataStubRepository()) -> MealImageViewModel {
        MealImageViewModel(dataRepository: dataRepository)
    }
}
