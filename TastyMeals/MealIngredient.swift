//
//  MealIngredient.swift
//  TastyMeals
//

import Foundation

/// Meal ingredient model.
struct MealIngredient: Identifiable {
    let id: UUID
    let name: String
    let measurement: String

    /// Creates a `MealIngredient`.
    /// - Parameters:
    ///   - id: The ingredient id, a `UUID` by default.
    ///   - name: The ingredient name.
    ///   - measurement: The ingredient measurement.
    init(id: UUID = UUID(), name: String, measurement: String) {
        self.id = id
        self.name = name
        self.measurement = measurement
    }

    var description: String {
        String(format: NSLocalizedString("%@: %@", comment: "Ingredient name and measurement description"), name, measurement)
    }
}
