//
//  TastyMealsApp.swift
//  TastyMeals
//

import SwiftUI

/// An app that displays dessert recipes including the recipe names, photos, ingredients with measurements, and cooking instructions.
@main
struct TastyMealsApp: App {
    private var isTest: Bool {
        NSClassFromString("XCTestCase") != nil
    }

    /// The content and behavior of the app.
    var body: some Scene {
        WindowGroup {
            if !isTest {
                MealListContainerView()
            }
        }
    }
}
