//
//  MealDetailInstructionsView.swift
//  TastyMeals
//

import SwiftUI

/// Meal detail instructions view.
@MainActor
struct MealDetailInstructionsView: View {
    private let headingButtonPadding = 5.0

    /// The meal instructions to display.
    var instructions: String

    /// The content and behavior of the view.
    var body: some View {
        VStack {
            Text("Instructions", comment: "Meal instructions section title.")
                .accessibilityAddTraits(.isHeader)
                .accessibilityHeading(.h2)
                .font(.title)
                .fontWeight(.medium)
                .padding(.bottom, headingButtonPadding)

            Text(instructions)
                .accessibilityLabel(
                    // swiftlint:disable:next line_length
                    Text("Instructions: \(instructions)", comment: "Accessibility label for the meal instructions. Variable is the meal instructions.")
                )
        }
    }
}
