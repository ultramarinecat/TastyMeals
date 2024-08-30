//
//  MealDetailRepository.swift
//  TastyMeals
//

import Foundation
import OSLog

// swiftlint:disable:next force_unwrapping
private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: MealDetailRepository.self))

/// Meal detail repository that fetches meal details.
struct MealDetailRepository: MealDetailRepositoryProtocol {
    private let dataRepository: MealDataRepository

    /// Creates a `MealListRepository` with the given `dataRepository` to use for fetching meal data.
    /// - Parameter dataRepository: Repository used to fetch meal data, `MealDBDataRepository` by default.
    init(dataRepository: MealDataRepository = MealDBDataRepository()) {
        self.dataRepository = dataRepository
    }

    /// Fetches the meal details for the given `mealID`.
    /// - Parameter mealID: The id of the `Meal` for which to fetch details.
    /// - Returns: `Meal` populated with the meal details.
    func fetchMeal(for mealID: String) async throws -> Meal {
        let data = try await dataRepository.fetchMealData(for: mealID)
        let mealsWrapper = try JSONDecoder().decode(MealsWrapper.self, from: data)
        let meal = mealsWrapper.meals.first

        guard let meal else {
            logger.warning("Fetch meal details request returned no meals for meal id: \(mealID)")
            throw TastyMealsError.noMealDetails(mealID: mealID)
        }
        return meal
    }
}
