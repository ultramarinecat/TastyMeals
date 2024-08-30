//
//  MealIngredientsViewModel.swift
//  TastyMeals
//

import Foundation

/// Meal ingredients view model.
@Observable
final class MealIngredientsViewModel {
    /// Array of `Ingredient`s.
    @MainActor private(set) var ingredients: [MealIngredient]?

    /// Handles tasks that need to be performed before view appears, creates the ingredients list for the given `meal`.
    /// - Parameter meal: The `Meal` for which to display ingredients.
    @MainActor
    func handleViewWillAppear(with meal: Meal) {
        ingredients = makeIngredients(for: meal)
    }

    private func makeIngredients(for meal: Meal) -> [MealIngredient] {
        let ingredients = [
            meal.ingredient1, meal.ingredient2, meal.ingredient3, meal.ingredient4, meal.ingredient5, meal.ingredient6, meal.ingredient7,
            meal.ingredient8, meal.ingredient9, meal.ingredient10, meal.ingredient11, meal.ingredient12, meal.ingredient13,
            meal.ingredient14, meal.ingredient15, meal.ingredient16, meal.ingredient17, meal.ingredient18, meal.ingredient19,
            meal.ingredient20
        ]

        let measurements = [
            meal.measurement1, meal.measurement2, meal.measurement3, meal.measurement4, meal.measurement5, meal.measurement6,
            meal.measurement7, meal.measurement8, meal.measurement9, meal.measurement10, meal.measurement11, meal.measurement12,
            meal.measurement13, meal.measurement14, meal.measurement15, meal.measurement16, meal.measurement17, meal.measurement18,
            meal.measurement19, meal.measurement20
        ]

        var ingredientsList: [MealIngredient] = []
        for (ingredient, measurement) in zip(ingredients, measurements) {
            if let ingredient, let measurement, !ingredient.isEmpty, !measurement.isEmpty {
                ingredientsList.append(MealIngredient(name: ingredient, measurement: measurement))
            }
        }

        return ingredientsList
    }
}
