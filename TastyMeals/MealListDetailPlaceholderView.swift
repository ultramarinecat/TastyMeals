//
//  MealListDetailPlaceholderView.swift
//  TastyMeals
//

import SwiftUI

/// Meal list detail placeholder view.
struct MealListDetailPlaceholderView: View {
    private static let backgroundAccentColorOpacity = 0.2
    private let mealSelectionPlaceholder = String(localized: "Please select a tasty dessert 🍰", comment: "Meal selection placeholder.")

    /// The content and behavior of the view.
    var body: some View {
        Text(mealSelectionPlaceholder)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.accentColor.opacity(MealListDetailPlaceholderView.backgroundAccentColorOpacity))
    }
}
