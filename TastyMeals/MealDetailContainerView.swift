//
//  MealDetailContainerView.swift
//  TastyMeals
//

import SwiftUI

/// Meal detail container view.
struct MealDetailContainerView: View {
    @State private var viewModel = MealDetailViewModel()

    /// The meal for which to display details.
    let meal: Meal

    /// The content and behavior of the view.
    var body: some View {
        MealDetailView(viewModel: viewModel)
            .task(id: meal) {
                await viewModel.handleViewWillAppear(with: meal)
            }
    }
}
