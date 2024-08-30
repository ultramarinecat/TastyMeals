//
//  LoadingView.swift
//  TastyMeals
//

import SwiftUI

/// Loading view.
struct LoadingView: View {
    /// The content and behavior of the view.
    var body: some View {
        ProgressView()
            .accessibilityElement(children: .ignore)
            .accessibilityAddTraits(.isImage)
            .accessibilityLabel("Loading")
    }
}
