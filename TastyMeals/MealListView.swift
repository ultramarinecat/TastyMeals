//
//  MealListView.swift
//  TastyMeals
//

import SwiftUI

/// Meal list view.
@MainActor
struct MealListView: View {
    private let errorMessageHorizontalPadding = 20.0
    private let refreshButtonTopPadding = 8.0
    private let backgroundAccentColorOpacity = 0.2

    /// The view model.
    let viewModel: MealListViewModel

    /// The content and behavior of the view.
    var body: some View {
        ZStack {
            if let errorMessage = viewModel.errorMessage {
                VStack {
                    Text(errorMessage)
                        .accessibilityLabel(
                            // swiftlint:disable:next line_length
                            Text("Error message: \(errorMessage)", comment: "Accessibility label for a meal error message. Variable is the error message.")
                        )
                        .padding(.horizontal, errorMessageHorizontalPadding)
                    Button(String(localized: "Refresh", comment: "Refresh meal list button label.")) {
                        Task {
                            await viewModel.handleRefreshButtonTap()
                        }
                    }
                    .buttonStyle(.bordered)
                    .accessibilityLabel(Text("Refresh meals", comment: "Accessibility label for the refresh meal list button."))
                    .padding(.top, refreshButtonTopPadding)
                }
            } else if let meals = viewModel.meals {
                MealListNavigationView(meals: meals)
            } else {
                LoadingView()
                    .accessibilityLabel(Text("Loading meals", comment: "Accessibility label for the loading meal list progress indicator."))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.accentColor.opacity(backgroundAccentColorOpacity))
    }
}
