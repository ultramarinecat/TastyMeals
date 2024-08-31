//
//  MealListRepository.swift
//  TastyMeals
//

import Foundation
import OSLog

// swiftlint:disable:next force_unwrapping
private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: MealListRepository.self))

/// Meal list repository that fetches meals.
struct MealListRepository: MealListRepositoryProtocol {
    private let dataRepository: MealDataRepository

    /// Creates a `MealListRepository` with the given `datarRepository` to use for fetching meal data.
    /// - Parameter dataRepository: Repository used to fetch meal data, `MealDBDataRepository` by default.
    init(dataRepository: MealDataRepository = MealDBDataRepository()) {
        self.dataRepository = dataRepository
    }

    /// Fetches the list of meals.
    /// - Returns: An `Array` of `Meal`s.
    /// - Throws: An error if fetching meals is unsuccesful.
    func fetchMeals() async throws -> [Meal] {
        let data = try await dataRepository.fetchMealsData()
        let mealsWrapper = try JSONDecoder().decode(MealsWrapper.self, from: data)
        let meals = mealsWrapper.meals

        guard !meals.isEmpty else {
            logger.warning("Fetch meals request returned no meals")
            throw TastyMealsError.noMeals
        }
        return meals
    }
}
