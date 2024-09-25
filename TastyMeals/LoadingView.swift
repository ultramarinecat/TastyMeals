//
//  LoadingView.swift
//  TastyMeals
//

import SwiftUI

/// Loading view.
@MainActor
struct LoadingView: View {
    /// The content and behavior of the view.
    var body: some View {
        ProgressView()
            .accessibilityElement(children: .ignore)
            .accessibilityAddTraits(.isImage)
            .accessibilityLabel(Text("Loading", comment: "Accessibility label for the loading progress indicator."))
    }
}
