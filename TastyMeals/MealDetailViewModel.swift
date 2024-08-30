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
    /// - Parameter repository: Repository used to fetch meal details, `MealDetailMealDBRepository` by default.
    init(repository: MealDetailRepositoryProtocol = MealDetailRepository()) {
        self.repository = repository
    }

    /// Handles tasks that need to be performed before view appears. Updates details for the given `meal`.
    /// - Parameter meal: The `Meal` for which to display details.
    @MainActor
    func handleViewWillAppear(with meal: Meal) async {
        do {
            clearPreviousMeal()
            let meal = try await repository.fetchMeal(for: meal.id)
            try Task.checkCancellation()

            clearErrorMessage()
            self.meal = meal
        } catch {
            guard !Task.isCancelled else {
                logger.debug("Fetch details for meal with id: \(meal.id) task cancelled")
                return
            }

            logger.info("\(error.localizedDescription)")
            errorMessage = "Could not load your dessert 😿. Please try again later 🍰"
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
