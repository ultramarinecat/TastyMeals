//
//  MealImageContainerView.swift
//  TastyMeals
//

import SwiftUI

/// Meal image container view.
struct MealImageContainerView: View {
    @State private var viewModel = MealImageViewModel()

    /// The meal for which to display the image.
    let meal: Meal
    /// Boolean value indicating whether the image is a preview.
    let isPreview: Bool

    /// The content and behavior of the view.
    var body: some View {
        MealImageView(viewModel: viewModel, isPreview: isPreview)
            .task(id: meal) {
                await viewModel.handleViewWillAppear(with: meal, isPreview: isPreview)
            }
    }
}
