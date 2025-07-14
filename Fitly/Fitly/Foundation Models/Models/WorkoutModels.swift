//
//  WorkoutModels.swift
//  Fitly
//
//  Created by Govind Sah on 14/07/25.
//

import Foundation
import FoundationModels

// MARK: - Generable Workout Plan Models

@Generable
struct WorkoutPlan: Codable, Equatable {
    var days: [WorkoutDay]
    var tips: [WorkoutTip]
}

@Generable
struct WorkoutDay: Codable, Equatable {
    var title: String           // e.g., "Day 1: Full Body Strength Training"
    var warmUp: String?        // e.g., "5-10 minutes of dynamic stretches"
    var activities: [WorkoutActivity]
    var notes: String?         // e.g., for rest or light activity days
}

@Generable
enum WorkoutActivity: Codable, Equatable {
    case exercise(Exercise)
    case cardio(Cardio)
    case flexibility(Flexibility)
    case recovery(Recovery)
}

@Generable
struct Exercise: Codable, Equatable {
    var name: String
    var sets: Int?
    var reps: String? // e.g., "8-12 reps" or "15 reps per side"
    var duration: String? // For planks or similar (e.g., "30-60 seconds")
    var notes: String?
}

@Generable
struct Cardio: Codable, Equatable {
    var description: String // e.g., "20-30 minutes of moderate-intensity cardio (cycling, elliptical, or swimming)"
    var duration: String?
}

@Generable
struct Flexibility: Codable, Equatable {
    var description: String // e.g., "Yoga or Pilates session focusing on flexibility and core stability"
    var duration: String?
}

@Generable
struct Recovery: Codable, Equatable {
    var description: String // e.g., "Light activities such as walking, yoga, or a gentle swim"
    var duration: String?
}

@Generable
struct WorkoutTip: Codable, Equatable {
    var category: String // e.g., "Nutrition", "Hydration", "Sleep", "Monitor Progress"
    var text: String
}
