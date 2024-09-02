//
//  MealDetailView.swift
//  TastyMeals
//

import SwiftUI

/// Meal detail view.
struct MealDetailView: View {
    private static let errorMessagePadding = 18.0
    private static let imageViewTopPadding = 5.0
    private static let ingredientsViewTopPadding = 16.0
    private static let instructionsStackTopPadding = 12.0
    private static let scrollViewStackHorizontalPadding = 20.0
    private static let scrollViewStackBottomPadding = 6.0
    private static let backgroundAccentColorOpacity = 0.2

    /// The view model.
    let viewModel: MealDetailViewModel

    /// The content and behavior of the view.
    var body: some View {
        ZStack {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .accessibilityLabel(
                        // swiftlint:disable:next line_length
                        Text("Error message: \(errorMessage)", comment: "Accessibility label for a meal error message. Variable is the error message.")
                    )
                    .padding(MealDetailView.errorMessagePadding)
            } else if let meal = viewModel.meal {
                ScrollView {
                    VStack {
                        Text(meal.name)
                            .accessibilityAddTraits(.isHeader)
                            .accessibilityHeading(.h1)
                            .accessibilityLabel(
                                // swiftlint:disable:next line_length
                                Text("Meal name: \(meal.name)", comment: "Accessibility label for the meal name. Variable is the meal name.")
                            )
                            .font(.title)
                            .fontWeight(.semibold)

                        MealImageContainerView(meal: meal, isPreview: false)
                            .padding(.top, MealDetailView.imageViewTopPadding)

                        MealIngredientsContainerView(meal: meal)
                            .padding(.top, MealDetailView.ingredientsViewTopPadding)

                        if let instructions = meal.instructions {
                            MealDetailInstructionsView(instructions: instructions)
                                .padding(.top, MealDetailView.instructionsStackTopPadding)
                        }
                    }
                    .padding(.horizontal, MealDetailView.scrollViewStackHorizontalPadding)
                    .padding(.bottom, MealDetailView.scrollViewStackBottomPadding)
                }
            } else {
                LoadingView()
                    // swiftlint:disable:next line_length
                    .accessibilityLabel(Text("Loading meal details", comment: "Accessibility label for the meal details loading indicator."))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.accentColor.opacity(MealDetailView.backgroundAccentColorOpacity))
    }
}
