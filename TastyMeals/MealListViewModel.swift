//
//  MealListViewModel.swift
//  TastyMeals
//

import Foundation
import OSLog

// swiftlint:disable:next force_unwrapping
private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: MealListViewModel.self))

/// Meal list view model.
@Observable
final class MealListViewModel {
    /// Array of `Meal`s.
    @MainActor private(set) var meals: [Meal]?

    /// Error message to display.
    @MainActor private(set) var errorMessage: String?

    @ObservationIgnored private let repository: MealListRepositoryProtocol

    /// Creates a `MealListViewModel` with the given `repository` to use for fetching meals.
    /// - Parameter repository: Repository used to fetch meals, `MealListRepository` by default.
    init(repository: MealListRepositoryProtocol = MealListRepository()) {
        self.repository = repository
    }

    /// Handles tasks that need to be performed before view appears. Updates the list of meals, sorts the meals alphabetically.
    func handleViewWillAppear() async {
        await updateMeals()
    }

    /// Handles refresh button tap. Updates the list of meals, sorts the meals alphabetically.
    @MainActor
    func handleRefreshButtonTap() async {
        errorMessage = nil
        await updateMeals()
    }

    @MainActor
    private func updateMeals() async {
        do {
            let meals = try await repository.fetchMeals()
            try Task.checkCancellation()

            self.meals = meals.sorted {
                $0.name < $1.name
            }
        } catch {
            guard !Task.isCancelled else {
                logger.debug("Fetch meals task cancelled")
                return
            }

            logger.warning("Failed to fetch meals: \(error.localizedDescription)")
            errorMessage = String(
                localized: "Could not load your tasty desserts 😿. Please try again later 🍰",
                comment: "Meal list error message."
            )
        }
    }
}
