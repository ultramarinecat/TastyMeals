//
//  MealImageViewModel.swift
//  TastyMeals
//

import Foundation
import OSLog

// swiftlint:disable:next force_unwrapping
private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: MealImageViewModel.self))

/// Meal image view model.
@Observable
final class MealImageViewModel {
    /// Image data `URL`
    @MainActor private(set) var imageDataURL: URL?

    /// Image description.
    @MainActor private(set) var imageDescription: String?

    @ObservationIgnored private let dataRepository: MealDataRepository

    /// Creates a `MealImageViewModel` with the given `dataRepository` to use for fetching meal image data.
    /// - Parameter dataRepository: Repository used to fetch meal image data, `MealDBDataRepository` by default.
    init(dataRepository: MealDataRepository = MealDBDataRepository()) {
        self.dataRepository = dataRepository
    }

    /// Handles tasks that need to be performed before view appears. Updates image data url for the given `meal`.
    /// - Parameter meal: The `Meal` for which to display the image.
    /// - Parameter isPreview: Boolean value indicating whether the image is a preview.
    @MainActor
    func handleViewWillAppear(with meal: Meal, isPreview: Bool) async {
        do {
            let imageURLString = isPreview ? meal.imagePreviewURLString : meal.imageURLString
            let imageDataURL = try await dataRepository.fetchMealImageDataURL(urlString: imageURLString)
            try Task.checkCancellation()

            self.imageDataURL = imageDataURL
            self.imageDescription = meal.name
        } catch {
            guard !Task.isCancelled else {
                logger.debug("Fetch image data for meal with id: \(meal.id) task cancelled")
                return
            }
            logger.warning("Failed to fetch meal image data: \(error.localizedDescription)")
        }
    }
}
