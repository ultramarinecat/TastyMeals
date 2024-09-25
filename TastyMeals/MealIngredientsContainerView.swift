//
//  MealIngredientsContainerView.swift
//  TastyMeals
//

import SwiftUI

/// Meal ingredients container view.
@MainActor
struct MealIngredientsContainerView: View {
    @State private var viewModel = MealIngredientsViewModel()

    /// The meal for which to display ingredients.
    let meal: Meal

    /// The content and behavior of the view.
    var body: some View {
        MealIngredientsView(viewModel: viewModel)
            .task(id: meal) {
                viewModel.handleViewWillAppear(with: meal)
            }
    }
}
