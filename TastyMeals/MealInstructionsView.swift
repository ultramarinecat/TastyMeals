//
//  MealInstructionsView.swift
//  TastyMeals
//

import SwiftUI

/// Meal instructions view.
struct MealInstructionsView: View {
    private static let headingButtonPadding = 5.0

    /// The meal instructions to display.
    var instructions: String

    /// The content and behavior of the view.
    var body: some View {
        VStack {
            Text("Instructions")
                .accessibilityAddTraits(.isHeader)
                .accessibilityHeading(.h2)
                .font(.title)
                .fontWeight(.medium)
                .padding(.bottom, MealInstructionsView.headingButtonPadding)

            Text(instructions)
                .accessibilityLabel("Instructions: \(instructions)")
        }
    }
}
