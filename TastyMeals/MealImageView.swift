//
//  MealImageView.swift
//  TastyMeals
//

import SwiftUI

/// Meal image view.
struct MealImageView: View {
    private static let imageWidth = 300.0
    private static let imageHeight = 300.0
    private static let imagePreviewWidth = 50.0
    private static let imagePreviewHeight = 50.0
    private static let imageCornerRadius = 8.0
    private static let loadFailureSystemSymbolImageName = "photo"

    /// The view model.
    let viewModel: MealImageViewModel
    /// Boolean value indicating whether the image is a preview.
    let isPreview: Bool

    /// The content and behavior of the view.
    var body: some View {
        AsyncImage(url: viewModel.imageDataURL) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .accessibilityElement(children: .ignore)
                    .accessibilityAddTraits(.isImage)
                    .accessibilityLabel(viewModel.imageDescription ?? "")
            } else if phase.error != nil {
                Image(systemName: MealImageView.loadFailureSystemSymbolImageName)
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
                    .accessibilityLabel("Failed to load")
            } else {
                LoadingView()
            }
        }
        .frame(
            width: isPreview ? MealImageView.imagePreviewWidth : MealImageView.imageWidth,
            height: isPreview ? MealImageView.imagePreviewWidth : MealImageView.imageWidth
        )
        .cornerRadius(MealImageView.imageCornerRadius)
    }
}
