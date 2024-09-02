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

    /// The ingredient description.
    var description: String {
        String(
            localized: "\(name): \(measurement)",
            comment: "Meal ingredient description. First variable is the ingredient name. Second variable is the ingredient measurement."
        )
    }
}
