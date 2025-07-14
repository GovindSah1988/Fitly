//
//  DietModels.swift
//  Fitly
//
//  Created by Govind Sah on 13/07/25.
//

import FoundationModels

@Generable
struct DietSuggestion {
    @Guide(description: "A desciption of diet plan")
    var description: String
    
    @Guide(description: "A list of meal suggestions for different time of day")
    var mealSuggestions: [MealSuggestionsWithCaloriesDetails]
}

@Generable
struct MealSuggestionsWithCaloriesDetails {
    @Guide(description: "A meal for a time of day")
    var meal: Meal
}

@Generable
struct Meal: Hashable {
    var type: MealType

    @Guide(description: "The lower calory range for the meal, value in kilo calories")
    var lowerCaloryRangeInKCal: Int

    @Guide(description: "The higher calory range for the meal, value in kilo calories")
    var higherCaloryRangeInKCal: Int

    var mealItems: [MealItem]

    var nameAndCalories: String {
        type.description + ": (" + "\(lowerCaloryRangeInKCal)" + "-" + "\(higherCaloryRangeInKCal)" + " kcal)"
    }
}

@Generable
enum MealType {
    case breakfast
    case lunch
    case snacks
    case dinner

    var description: String {
        switch self {
        case .breakfast:
            return "🥣 Breakfast"
        case .lunch:
            return "🍗 Lunch"
        case .snacks:
            return "🥜 Snacks"
        case .dinner:
            return "🥗 Dinner"
        }
    }
}

@Generable
struct MealItem: Hashable {
    var name: String // e.g. 4 boiled egg whites + 1 yolk , 1 slice whole wheat bread or oats , Green tea or black coffee , Grilled chicken breast , paneer etc
    
    @Guide(description: "The calory breakdown for the meal item, value in kilo calories")
    var caloryBreakdown: Float
    
    var nameAndCalory: String {
        return "\(name): \(caloryBreakdown) kCal"
    }
    
//    var kiloCalories: String {
//        return "\(Int(Double(caloryBreakdown) / 1000.0)) Kcal"
//    }
}
