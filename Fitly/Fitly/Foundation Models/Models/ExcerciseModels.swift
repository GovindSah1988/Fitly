//
//  ExcerciseModels.swift
//  Fitly
//
//  Created by Govind Sah on 14/07/25.
//

import FoundationModels

@Generable
struct WorkoutSuggestion {
    @Guide(description: "A desciption of workout plan")
    var description: String
}

@Generable
struct ExerciseSuggestion {
    @Guide(description: "A description of the fitness and exercise plan")
    var description: String
    
    @Guide(description: "A list of sections in the exercise suggestion, such as Cardio, Strength, Flexibility, etc.")
    var sections: [ExerciseSection]
}

@Generable
enum ExerciseSectionType {
    case cardiovascular
    case strengthTraining
    case flexibilityAndBalance
    case varietyAndProgression
    case consistencyAndRest
    case nutritionAndHydration
    case monitorAndAdjust

    var description: String {
        switch self {
        case .cardiovascular:
            return "Cardiovascular Exercise"
        case .strengthTraining:
            return "Strength Training"
        case .flexibilityAndBalance:
            return "Flexibility and Balance"
        case .varietyAndProgression:
            return "Variety and Progression"
        case .consistencyAndRest:
            return "Consistency and Rest"
        case .nutritionAndHydration:
            return "Nutrition and Hydration"
        case .monitorAndAdjust:
            return "Monitor and Adjust"
        }
    }
}

@Generable
struct ExerciseSection {
    @Guide(description: "Section type, such as Cardio, Strength, etc.")
    var type: ExerciseSectionType
    
    @Guide(description: "General guidance for this section")
    var sectionDescription: String
    
    @Guide(description: "List of specific exercise items, tips, or activities under this section")
    var items: [ExerciseItem]
}

@Generable
struct ExerciseItem: Hashable {
    @Guide(description: "The name or title of the exercise/tip/activity with appropriate emojies at the start of the sentence.")
    var name: String
    
    @Guide(description: "A detailed explanation or recommendation about the exercise or activity.")
    var details: String
}
