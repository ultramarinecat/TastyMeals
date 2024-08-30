//
//  MealListDetailPlaceholderView.swift
//  TastyMeals
//

import SwiftUI

/// Meal list detail placeholder view.
struct MealListDetailPlaceholderView: View {
    private static let backgroundAccentColorOpacity = 0.2

    /// The content and behavior of the view.
    var body: some View {
        Text("Please select a tasty dessert 🍰")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.accentColor.opacity(MealListDetailPlaceholderView.backgroundAccentColorOpacity))
    }
}
