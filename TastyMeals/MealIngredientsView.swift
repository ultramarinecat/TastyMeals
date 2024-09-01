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
                    Text("Ingredients")
                        .accessibilityAddTraits(.isHeader)
                        .accessibilityHeading(.h2)
                        .font(.title)
                        .fontWeight(.medium)
                        .padding(.bottom, MealIngredientsView.headingBottomPadding)

                    VStack(alignment: .leading) {
                        ForEach(ingredients) { ingredient in
                            Text(ingredient.description)
                                .accessibilityLabel("Ingredient: \(ingredient.description)")
                        }
                    }
                }
            }
        } else {
            LoadingView()
                .accessibilityLabel("Loading ingredients")
        }
    }
}
