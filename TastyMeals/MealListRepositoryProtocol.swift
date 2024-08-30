//
//  MealListRepositoryProtocol.swift
//  TastyMeals
//

/// Meal list repository for fetching meals.
protocol MealListRepositoryProtocol {
    /// Fetches the list of meals.
    /// - Returns: An `Array` of `Meal`s.
    func fetchMeals() async throws -> [Meal]
}
