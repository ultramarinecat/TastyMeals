//
//  MealIngredientsView.swift
//  TastyMeals
//

import SwiftUI

/// Meal ingredients view.
struct MealIngredientsView: View {
    private static let headingBottomPadding = 5.0

    /// The view model.
    let viewModel: MealIngredientsViewModel

    /// The content and behavior of the view.
    var body: some View {
        if let ingredients = viewModel.ingredients {
            if !ingredients.isEmpty {
                VStack {
                    Text("Ingredients", comment: "Meal ingredients section title.")
                        .accessibilityAddTraits(.isHeader)
                        .accessibilityHeading(.h2)
                        .font(.title)
                        .fontWeight(.medium)
                        .padding(.bottom, MealIngredientsView.headingBottomPadding)

                    VStack(alignment: .leading) {
                        ForEach(ingredients) { ingredient in
                            Text(ingredient.description)
                                .accessibilityLabel(
                                    Text("Ingredient: \(ingredient.description)", comment: "Accessibility label for a meal ingredient.")
                                )
                        }
                    }
                }
            }
        } else {
            LoadingView()
                .accessibilityLabel(Text("Loading ingredients", comment: "Accessibility label for the meal ingredients loading indicator."))
        }
    }
}
