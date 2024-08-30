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
            return NSLocalizedString("Unexpected error", comment: "Unexpected error")
        case .invalidURL(let string):
            return NSLocalizedString("Invalid url: \(string)", comment: "Invalid url")
        case .unsuccessful(let statusCode):
            return NSLocalizedString("Unsuccessful request with status code: \(statusCode)", comment: "Unsuccessful request")
        case .noMeals:
            return NSLocalizedString("No meals returned", comment: "No meals returned")
        case .noMealDetails(let mealID):
            return NSLocalizedString("No meal details returned for meal id: \(mealID)", comment: "No meal details returned")
        }
    }
}
