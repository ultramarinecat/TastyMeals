//
//  MealDetailRepositoryProtocol.swift
//  TastyMeals
//

/// Meal detail repository for fetching meal details.
protocol MealDetailRepositoryProtocol {
    /// Fetches the meal details for the given `mealID`.
    /// - Parameter mealID: The id of the `Meal` for which to fetch details.
    /// - Returns: `Meal` populated with the meal details.
    /// - Throws: An error if fetching meal is unsuccesful.
    func fetchMeal(for mealID: String) async throws -> Meal
}
