//
//  MealIngredient.swift
//  TastyMeals
//

import Foundation

/// Meal ingredient model.
struct MealIngredient: Identifiable {
    let id = UUID()
    let name: String
    let measurement: String

    var description: String {
        "\(name): \(measurement)"
    }
}
