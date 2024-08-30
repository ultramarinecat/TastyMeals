//
//  MealIngredient.swift
//  TastyMeals
//

import Foundation

/// Meal ingredient model.
struct MealIngredient: Identifiable {
    var id = UUID()
    let name: String
    let measurement: String

    var description: String {
        "\(name): \(measurement)"
    }
}
