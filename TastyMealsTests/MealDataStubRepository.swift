//
//  MealDataStubRepository.swift
//  TastyMeals
//

import Foundation

@testable import TastyMeals

/// Stub repository for fetching meal data.
struct MealDataStubRepository: MealDataRepository {
    static let mealID = "1"
    static let mealName = "meal"
    static let mealImageURLString = "meal.jpg"
    static let mealInstructions = "instructions"
    static let mealIngredient1 = "ingredient 1"
    static let mealIngredient2 = "ingredient 2"
    static let mealMeasurement1 = "measurement 1"
    static let mealMeasurement2 = "measurement 2"

    static let meal1ID = "1"
    static let meal2ID = "2"
    static let meal1Name = "meal a"
    static let meal2Name = "meal b"
    static let meal1ImageURLString = "meal1.jpg"
    static let meal2ImageURLString = "meal2.jpg"

    private let isSuccessful: Bool
    private let isOrderedByName: Bool
    private let isEmpty: Bool

    private let emptyMealsData: Data = {
        Data(
            // swiftlint:disable indentation_width
            """
            {
              "meals": []
            }
            """.utf8
            // swiftlint:enable indentation_width
        )
    }()

    private let unsuccessfulError: TastyMealsError = {
        TastyMealsError.unsuccessful(statusCode: 500)
    }()

    /// Creates a stub `MealDataRepository` for fetching meal data.
    /// - Parameters:
    ///   - isSuccessful: Boolean value indicating whether fetching is successful, `true` by default.
    ///   - isOrderedByName: Boolean value indicating whether the fetched meals are ordered by name, `true` by default.
    ///   - isEmpty: Boolean value indicating whether the fetched meals wrapper is empty, `false` by default.
    init(isSuccessful: Bool = true, isOrderedByName: Bool = true, isEmpty: Bool = false) {
        self.isSuccessful = isSuccessful
        self.isOrderedByName = isOrderedByName
        self.isEmpty = isEmpty
    }

    /// Fetches the stub meals data.
    /// - Returns: The meals `Data`.
    func fetchMealsData() async throws -> Data {
        guard isSuccessful else {
            throw unsuccessfulError
        }

        guard !isEmpty else {
            return emptyMealsData
        }

        let meal1Name = isOrderedByName ? MealDataStubRepository.meal1Name : MealDataStubRepository.meal2Name
        let meal2Name = isOrderedByName ? MealDataStubRepository.meal2Name : MealDataStubRepository.meal1Name

        return Data(
            // swiftlint:disable indentation_width
            """
            {
              "meals": [
                {
                  "strMeal": "\(meal1Name)",
                  "strMealThumb": "\(MealDataStubRepository.meal1ImageURLString)",
                  "idMeal": "\(MealDataStubRepository.meal1ID)"
                },
                {
                  "strMeal": "\(meal2Name)",
                  "strMealThumb": "\(MealDataStubRepository.meal2ImageURLString)",
                  "idMeal": "\(MealDataStubRepository.meal2ID)"
                }
              ]
            }
            """.utf8
            // swiftlint:enable indentation_width
        )
    }

    /// Fetches the stub meal data for the given `mealID`.
    /// - Parameter mealID: The id of the `Meal` for which to fetch data.
    /// - Returns: The meal `Data` for the given `mealID`.
    func fetchMealData(for mealID: String) async throws -> Data {
        guard isSuccessful else {
            throw unsuccessfulError
        }

        guard !isEmpty else {
            return emptyMealsData
        }

        return Data(
            // swiftlint:disable indentation_width
            """
            {
              "meals": [
                {
                  "idMeal": "\(mealID)",
                  "strMeal": "\(MealDataStubRepository.mealName)",
                  "strInstructions": "\(MealDataStubRepository.mealInstructions)",
                  "strMealThumb": "\(MealDataStubRepository.mealImageURLString)",
                  "strIngredient1": "\(MealDataStubRepository.mealIngredient1)",
                  "strIngredient2": "\(MealDataStubRepository.mealIngredient2)",
                  "strMeasure1": "\(MealDataStubRepository.mealMeasurement1)",
                  "strMeasure2": "\(MealDataStubRepository.mealMeasurement2)"
                }
              ]
            }
            """.utf8
            // swiftlint:enable indentation_width
        )
    }

    /// Fetches the stub data url for the given image `urlString`.
    /// - Parameter urlString: The URL string of the image for which to fetch data.
    /// - Returns: Image data `URL` for the given image `urlString`.
    func fetchMealImageDataURL(urlString: String) async throws -> URL {
        guard isSuccessful else {
            throw TastyMealsError.unsuccessful(statusCode: 500)
        }

        // swiftlint:disable:next force_unwrapping
        return URL(string: urlString)!
    }
}
