//
//  Meal.swift
//  TastyMeals
//

import Foundation

/// Meal model wrapper.
struct MealsWrapper: Codable {
    let meals: [Meal]
}

/// Meal model.
struct Meal: Equatable, Hashable, Identifiable {
    let id: String
    let name: String
    let imageURLString: String
    let instructions: String?

    let ingredient1: String?
    let ingredient2: String?
    let ingredient3: String?
    let ingredient4: String?
    let ingredient5: String?
    let ingredient6: String?
    let ingredient7: String?
    let ingredient8: String?
    let ingredient9: String?
    let ingredient10: String?
    let ingredient11: String?
    let ingredient12: String?
    let ingredient13: String?
    let ingredient14: String?
    let ingredient15: String?
    let ingredient16: String?
    let ingredient17: String?
    let ingredient18: String?
    let ingredient19: String?
    let ingredient20: String?

    let measurement1: String?
    let measurement2: String?
    let measurement3: String?
    let measurement4: String?
    let measurement5: String?
    let measurement6: String?
    let measurement7: String?
    let measurement8: String?
    let measurement9: String?
    let measurement10: String?
    let measurement11: String?
    let measurement12: String?
    let measurement13: String?
    let measurement14: String?
    let measurement15: String?
    let measurement16: String?
    let measurement17: String?
    let measurement18: String?
    let measurement19: String?
    let measurement20: String?

    var imagePreviewURLString: String {
        imageURLString + "/preview"
    }

    init(
        id: String,
        name: String,
        imageURLString: String,
        instructions: String? = nil,

        ingredient1: String? = nil,
        ingredient2: String? = nil,
        ingredient3: String? = nil,
        ingredient4: String? = nil,
        ingredient5: String? = nil,
        ingredient6: String? = nil,
        ingredient7: String? = nil,
        ingredient8: String? = nil,
        ingredient9: String? = nil,
        ingredient10: String? = nil,
        ingredient11: String? = nil,
        ingredient12: String? = nil,
        ingredient13: String? = nil,
        ingredient14: String? = nil,
        ingredient15: String? = nil,
        ingredient16: String? = nil,
        ingredient17: String? = nil,
        ingredient18: String? = nil,
        ingredient19: String? = nil,
        ingredient20: String? = nil,

        measurement1: String? = nil,
        measurement2: String? = nil,
        measurement3: String? = nil,
        measurement4: String? = nil,
        measurement5: String? = nil,
        measurement6: String? = nil,
        measurement7: String? = nil,
        measurement8: String? = nil,
        measurement9: String? = nil,
        measurement10: String? = nil,
        measurement11: String? = nil,
        measurement12: String? = nil,
        measurement13: String? = nil,
        measurement14: String? = nil,
        measurement15: String? = nil,
        measurement16: String? = nil,
        measurement17: String? = nil,
        measurement18: String? = nil,
        measurement19: String? = nil,
        measurement20: String? = nil
    ) {
        self.id = id
        self.name = name
        self.imageURLString = imageURLString
        self.instructions = instructions

        self.ingredient1 = ingredient1
        self.ingredient2 = ingredient2
        self.ingredient3 = ingredient3
        self.ingredient4 = ingredient4
        self.ingredient5 = ingredient5
        self.ingredient6 = ingredient6
        self.ingredient7 = ingredient7
        self.ingredient8 = ingredient8
        self.ingredient9 = ingredient9
        self.ingredient10 = ingredient10
        self.ingredient11 = ingredient11
        self.ingredient12 = ingredient12
        self.ingredient13 = ingredient13
        self.ingredient14 = ingredient14
        self.ingredient15 = ingredient15
        self.ingredient16 = ingredient16
        self.ingredient17 = ingredient17
        self.ingredient18 = ingredient18
        self.ingredient19 = ingredient19
        self.ingredient20 = ingredient20

        self.measurement1 = measurement1
        self.measurement2 = measurement2
        self.measurement3 = measurement3
        self.measurement4 = measurement4
        self.measurement5 = measurement5
        self.measurement6 = measurement6
        self.measurement7 = measurement7
        self.measurement8 = measurement8
        self.measurement9 = measurement9
        self.measurement10 = measurement10
        self.measurement11 = measurement11
        self.measurement12 = measurement12
        self.measurement13 = measurement13
        self.measurement14 = measurement14
        self.measurement15 = measurement15
        self.measurement16 = measurement16
        self.measurement17 = measurement17
        self.measurement18 = measurement18
        self.measurement19 = measurement19
        self.measurement20 = measurement20
    }
}

// MARK: - Codable

extension Meal: Codable {
    private enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageURLString = "strMealThumb"
        case instructions = "strInstructions"

        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"

        case measurement1 = "strMeasure1"
        case measurement2 = "strMeasure2"
        case measurement3 = "strMeasure3"
        case measurement4 = "strMeasure4"
        case measurement5 = "strMeasure5"
        case measurement6 = "strMeasure6"
        case measurement7 = "strMeasure7"
        case measurement8 = "strMeasure8"
        case measurement9 = "strMeasure9"
        case measurement10 = "strMeasure10"
        case measurement11 = "strMeasure11"
        case measurement12 = "strMeasure12"
        case measurement13 = "strMeasure13"
        case measurement14 = "strMeasure14"
        case measurement15 = "strMeasure15"
        case measurement16 = "strMeasure16"
        case measurement17 = "strMeasure17"
        case measurement18 = "strMeasure18"
        case measurement19 = "strMeasure19"
        case measurement20 = "strMeasure20"
    }
}
