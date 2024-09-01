//
//  MealListDetailPlaceholderView.swift
//  TastyMeals
//

import SwiftUI

/// Meal list detail placeholder view.
struct MealListDetailPlaceholderView: View {
    private static let backgroundAccentColorOpacity = 0.2
    private static let selectionPlaceholderText = "Please select a tasty dessert 🍰"

    /// The content and behavior of the view.
    var body: some View {
        Text(MealListDetailPlaceholderView.selectionPlaceholderText)
            .accessibilityLabel("Selection placeholder text: \(MealListDetailPlaceholderView.selectionPlaceholderText)")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.accentColor.opacity(MealListDetailPlaceholderView.backgroundAccentColorOpacity))
    }
}
