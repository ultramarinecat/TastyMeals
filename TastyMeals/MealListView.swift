//
//  MealListView.swift
//  TastyMeals
//

import SwiftUI

/// Meal list view.
struct MealListView: View {
    private static let errorMessageHorizontalPadding = 20.0
    private static let refreshButtonTopPadding = 8.0
    private static let backgroundAccentColorOpacity = 0.2

    /// The view model.
    let viewModel: MealListViewModel

    /// The content and behavior of the view.
    var body: some View {
        ZStack {
            if let errorMessage = viewModel.errorMessage {
                VStack {
                    Text(errorMessage)
                        .accessibilityLabel("Error message: \(errorMessage)")
                        .padding(.horizontal, MealListView.errorMessageHorizontalPadding)
                    Button("Refresh") {
                        Task {
                            await viewModel.handleRefreshButtonTap()
                        }
                    }
                    .buttonStyle(.bordered)
                    .accessibilityLabel("Refresh meals")
                    .padding(.top, MealListView.refreshButtonTopPadding)
                }
            } else if let meals = viewModel.meals {
                MealListNavigationView(meals: meals)
            } else {
                LoadingView()
                    .accessibilityLabel("Loading meals")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.accentColor.opacity(MealListView.backgroundAccentColorOpacity))
    }
}
