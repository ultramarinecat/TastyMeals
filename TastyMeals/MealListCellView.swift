//
//  MealListCellView.swift
//  TastyMeals
//

import SwiftUI

/// Meal list cell view.
struct MealListCellView: View {
    /// The meal to display.
    let meal: Meal

    /// The content and behavior of the view.
    var body: some View {
        HStack {
            MealImageContainerView(meal: meal, isPreview: true)
            Text(meal.name)
                .accessibilityLabel("Meal name: \(meal.name)")
        }
    }
}
