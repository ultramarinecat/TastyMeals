//
//  MealListRepositoryProtocol.swift
//  TastyMeals
//

/// Meal list repository for fetching meals.
protocol MealListRepositoryProtocol: Sendable {
    /// Fetches the list of meals.
    /// - Returns: An `Array` of `Meal`s.
    /// - Throws: An error if fetching meals is unsuccesful.
    func fetchMeals() async throws -> [Meal]
}
