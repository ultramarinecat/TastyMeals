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
            return String(format: NSLocalizedString("Invalid url: %@", comment: "Invalid url"), string)
        case .unsuccessful(let statusCode):
            // swiftlint:disable:next line_length
            return String(format: NSLocalizedString("Unsuccessful request with status code: %d", comment: "Unsuccessful request"), statusCode)
        case .noMeals:
            return NSLocalizedString("No meals returned", comment: "No meals returned")
        case .noMealDetails(let mealID):
            // swiftlint:disable:next line_length
            return String(format: NSLocalizedString("No meal details returned for meal id: %@", comment: "No meal details returned"), mealID)
        }
    }
}
