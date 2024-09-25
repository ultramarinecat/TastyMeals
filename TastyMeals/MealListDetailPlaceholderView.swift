//
//  MealListDetailPlaceholderView.swift
//  TastyMeals
//

import SwiftUI

/// Meal list detail placeholder view.
@MainActor
struct MealListDetailPlaceholderView: View {
    private let backgroundAccentColorOpacity = 0.2

    /// The content and behavior of the view.
    var body: some View {
        Text(String(localized: "Please select a tasty dessert 🍰", comment: "Meal selection placeholder."))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.accentColor.opacity(backgroundAccentColorOpacity))
    }
}
