//
//  MealImageView.swift
//  TastyMeals
//

import SwiftUI

/// Meal image view.
@MainActor
struct MealImageView: View {
    private let imageWidth = 300.0
    private let imageHeight = 300.0
    private let imagePreviewWidth = 50.0
    private let imagePreviewHeight = 50.0
    private let imageCornerRadius = 8.0
    private let loadFailureSystemSymbolImageName = "photo"

    private var imageAccessibilityLabel: String? {
        guard let imageDescription = viewModel.imageDescription else {
            return nil
        }
        return String(localized: "Image of \(imageDescription)", comment: "Accessibility label for the meal image.")
    }

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
                    .accessibilityLabel(imageAccessibilityLabel ?? "")
            } else if phase.error != nil {
                Image(systemName: loadFailureSystemSymbolImageName)
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
                    .accessibilityLabel(
                        Text("Failed to load meal image", comment: "Accessibility label for the meal image failed to load default image.")
                    )
            } else {
                LoadingView()
                    .accessibilityLabel(
                        Text("Loading meal image", comment: "Accessibility label for the loading meal image progress indicator.")
                    )
            }
        }
        .frame(
            width: isPreview ? imagePreviewWidth : imageWidth,
            height: isPreview ? imagePreviewHeight : imageHeight
        )
        .cornerRadius(imageCornerRadius)
    }
}
