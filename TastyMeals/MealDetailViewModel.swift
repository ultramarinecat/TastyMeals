//
//  MealDetailViewModel.swift
//  TastyMeals
//

import Foundation
import OSLog

// swiftlint:disable:next force_unwrapping
private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: MealDetailViewModel.self))

/// Meal detail view model.
@Observable
final class MealDetailViewModel {
    /// `Meal` for which to display details.
    @MainActor private(set) var meal: Meal?

    /// Error message to display.
    @MainActor private(set) var errorMessage: String?

    @ObservationIgnored private let repository: MealDetailRepositoryProtocol

    /// Creates a `MealDetailViewModel` with the given `repository` to use for fetching meal details.
    /// - Parameter repository: Repository used to fetch meal details, `MealDetailRepository` by default.
    init(repository: MealDetailRepositoryProtocol = MealDetailRepository()) {
        self.repository = repository
    }

    /// Handles tasks that need to be performed before view appears. Updates details for the given `meal`.
    /// - Parameter mealID: The id of the `Meal` for which to display details.
    @MainActor
    func handleViewWillAppear(for mealID: String) async {
        do {
            clearPreviousMeal()
            let meal = try await repository.fetchMeal(for: mealID)
            try Task.checkCancellation()

            clearErrorMessage()
            self.meal = meal
        } catch {
            guard !Task.isCancelled else {
                logger.debug("Fetch details for meal with id: \(mealID) task cancelled")
                return
            }

            logger.warning("Failed to fetch meal details: \(error.localizedDescription)")
            errorMessage = String(
                localized: "Could not load your dessert 😿. Please try again later 🍰",
                comment: "Meal details error message."
            )
        }
    }

    @MainActor
    private func clearPreviousMeal() {
        guard meal != nil else {
            return
        }
        meal = nil
    }

    @MainActor
    private func clearErrorMessage() {
        guard errorMessage != nil else {
            return
        }
        errorMessage = nil
    }
}
