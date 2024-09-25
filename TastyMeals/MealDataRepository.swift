//
//  MealDataRepository.swift
//  TastyMeals
//

import Foundation

/// Repository for fetching meal data.
protocol MealDataRepository: Sendable {
    /// Fetches the meals data.
    /// - Returns: The meals `Data`.
    func fetchMealsData() async throws -> Data

    /// Fetches the meal data for the given `mealID`.
    /// - Parameter mealID: The id of the `Meal` for which to fetch data.
    /// - Returns: The meal `Data` for the given `mealID`.
    func fetchMealData(for mealID: String) async throws -> Data

    /// Fetches the data url for the given image `urlString`.
    /// - Parameter urlString: The URL string of the image for which to fetch data.
    /// - Returns: Image data `URL` for the given image `urlString`.
    func fetchMealImageDataURL(urlString: String) async throws -> URL
}
