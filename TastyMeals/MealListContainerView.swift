//
//  MealListContainerView.swift
//  TastyMeals
//

import SwiftUI

/// Meal list container view.
@MainActor
struct MealListContainerView: View {
    @State private var viewModel = MealListViewModel()

    /// The content and behavior of the view.
    var body: some View {
        MealListView(viewModel: viewModel)
            .task {
                await viewModel.handleViewWillAppear()
            }
    }
}
