//
//  PopularWorkoutModels2.swift
//  Fitly
//
//  Created by Govind Sah on 15/07/25.
//


import Foundation
import FoundationModels

@Generable
struct PopularWorkoutSuggestion {
    @Guide(description: "A description of the popular workout plan")
    var description: String
    
    @Guide(description: "A list of popular workout programs.")
    var suggestions: [PopularWorkoutProgram]
}

@Generable
struct PopularWorkoutProgram: Codable, Equatable {
    @Guide(description: "The name/title of this workout program, e.g., 'Full-Body Strength Training'.")
    var name: String

    @Guide(description: "Category of the program, e.g., Strength, HIIT, Yoga, Cardio, Dance.")
    var type: ProgramType

    @Guide(description: "Optional summary or description for this program.")
    var description: String?

    @Guide(description: "List of required equipment, e.g., ['Dumbbells', 'Mat'].")
    var equipmentRequired: [String]

    @Guide(description: "Total estimated duration of the program, e.g., '45-60 minutes'.")
    var duration: String

    @Guide(description: "The main structure of this workout, including warm-up, main sections, and cool-down.")
    var plan: WorkoutStructure

    @Guide(description: "Estimated calorie burn for this workout session, e.g., '300-400 calories'.")
    var caloriesBurnedEstimate: String?

    @Guide(description: "Optional video resources or links for this program.")
    var videoResources: [VideoResource]?
}

@Generable
enum ProgramType: String, Codable, Equatable {
    case strength
    case hiit
    case yogaPilates
    case cardioCore
    case danceCardio
    case other
}

@Generable
struct WorkoutStructure: Codable, Equatable {
    @Guide(description: "The warm-up section/phase of the workout, if any.")
    var warmUp: PlanSection?

    @Guide(description: "The primary sections (circuits, flows, routines, etc.) for this workout.")
    var mainSections: [PlanSection]

    @Guide(description: "The cool-down section/phase of the workout, if any.")
    var coolDown: PlanSection?
}

@Generable
struct PlanSection: Codable, Equatable {
    @Guide(description: "Title or label for this section, e.g., 'Circuit (Repeat 2-3 times)'.")
    var title: String

    @Guide(description: "List of activities or steps in this section.")
    var activities: [WorkoutActivityDetail]

    @Guide(description: "Optional text for repeat instructions, e.g., 'Repeat 3 times'.")
    var repeatCount: String?
}

@Generable
enum WorkoutActivityDetail: Codable, Equatable {
    case namedActivity(NamedActivity)
    case freeText(String)
}

@Generable
struct NamedActivity: Codable, Equatable {
    @Guide(description: "The name of this activity or exercise, e.g., 'Burpees'.")
    var name: String

    @Guide(description: "Number of reps or details, e.g., '12 reps' or '15 reps per side'.")
    var reps: String?

    @Guide(description: "Duration for time-based activities, e.g., '30 seconds'.")
    var duration: String?

    @Guide(description: "Additional notes or details about this activity.")
    var notes: String?
}

@Generable
struct VideoResource: Codable, Equatable {
    @Guide(description: "Optional title for the video resource.")
    var title: String?

    @Guide(description: "Optional URL for the video resource.")
    var url: String?

    @Guide(description: "Notes or context for the video resource, if any.")
    var notes: String?
}
