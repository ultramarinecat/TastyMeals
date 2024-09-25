//
//  MealListNavigationView.swift
//  TastyMeals
//

import SwiftUI

/// Meal list navigation view.
@MainActor
struct MealListNavigationView: View {
    @State private var columnVisibility = NavigationSplitViewVisibility.doubleColumn

    /// The meals to display.
    let meals: [Meal]

    /// The content and behavior of the view.
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(meals) { meal in
                NavigationLink {
                    MealDetailContainerView(meal: meal)
                } label: {
                    MealListCellView(meal: meal)
                }
            }
            .navigationTitle(Text("Desserts", comment: "Meal list navigation title."))
        } detail: {
            MealListDetailPlaceholderView()
        }
        .navigationSplitViewStyle(.balanced)
    }
}
