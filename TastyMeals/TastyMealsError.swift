//
//  TastyMealsError.swift
//  TastyMeals
//

import Foundation

/// TastyMeals error types.
enum TastyMealsError: Error {
    /// Unexpected error.
    case unexpected
    /// Invalid URL.
    /// - Parameter string: The url string.
    case invalidURL(string: String)
    /// Unsuccessful request.
    /// - Parameter statusCode: The status code.
    case unsuccessful(statusCode: Int)
    /// No meals returned.
    case noMeals
    /// No meal details returned.
    /// - Parameter mealID: The meal id.
    case noMealDetails(mealID: String)
}

// MARK: - LocalizedError

extension TastyMealsError: LocalizedError {
    /// Localized error description.
    var errorDescription: String? {
        switch self {
        case .unexpected:
            return String(localized: "Unexpected error", comment: "Unexpected error.")
        case .invalidURL(let string):
            return String(localized: "Invalid url: \(string)", comment: "Invalid url error. Variable is the url string.")
        case .unsuccessful(let statusCode):
            return String(
                localized: "Unsuccessful request with status code: \(statusCode)",
                comment: "Unsuccessful request error. Variable is the status code.")
        case .noMeals:
            return String(localized: "No meals returned", comment: "No meals returned error.")
        case .noMealDetails(let mealID):
            return String(
                localized: "No meal details returned for meal id: \(mealID)",
                comment: "No meal details returned error. Variable is the meal id.")
        }
    }
}
