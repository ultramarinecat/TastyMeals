//
//  MealDBDataRepository.swift
//  TastyMeals
//

import Foundation
import OSLog

// swiftlint:disable:next force_unwrapping
private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: MealDBDataRepository.self))

/// Repository that fetches meal data from TheMealDB.
struct MealDBDataRepository: MealDataRepository {
    private static let mealsURLString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    private static let mealURLFormatString = "https://themealdb.com/api/json/v1/1/lookup.php?i=%@"

    /// Fetches the meals data.
    /// - Returns: The meals `Data.
    func fetchMealsData() async throws -> Data {
        let url = try makeURL(for: MealDBDataRepository.mealsURLString)
        return try await fetchData(for: url)
    }

    /// Fetches the meal data for the given `mealID`.
    /// - Parameter mealID: The id of the `Meal` for which to fetch data.
    /// - Returns: The `Data` for the given `mealID`.
    func fetchMealData(for mealID: String) async throws -> Data {
        let urlString = String(format: MealDBDataRepository.mealURLFormatString, mealID)
        let url = try makeURL(for: urlString)
        return try await fetchData(for: url)
    }

    /// Fetches the data url for the given image `urlString`.
    /// - Parameter urlString: The URL string of the image for which to fetch data.
    /// - Returns: Image data `URL` for the given image `urlString`.
    func fetchMealImageDataURL(urlString: String) async throws -> URL {
        let url = try makeURL(for: urlString)
        let data = try await fetchData(for: url)

        let dataURL = URL(string: "data:image/png;base64,\(data.base64EncodedString())")
        guard let dataURL else {
            logger.warning("Could not create data url for data fetched from url: \(url.absoluteString)")
            throw TastyMealsError.invalidURL(string: urlString)
        }
        return dataURL
    }

    private func fetchData(for url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return cachedResponse.data
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                logger.error("Unexpected URLResponse type")
                assertionFailure("Unexpected URLResponse type")
                throw TastyMealsError.unexpected
            }

            let statusCode = httpResponse.statusCode
            guard statusCode == 200 else {
                logger.warning("Request to url: \(url.absoluteString) unsuccesful: \(statusCode)")
                throw TastyMealsError.unsuccessful(statusCode: statusCode)
            }
            return data
        } catch {
            logger.warning("Failed to fetch data from url: \(url.absoluteString) with error: \(error.localizedDescription)")
            throw error
        }
    }

    private func makeURL(for urlString: String) throws -> URL {
        guard let url = URL(string: urlString) else {
            logger.error("Invalid url: \(urlString)")
            throw TastyMealsError.invalidURL(string: urlString)
        }
        return url
    }
}
