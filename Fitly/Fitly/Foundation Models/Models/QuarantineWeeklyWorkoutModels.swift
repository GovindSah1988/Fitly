//  QuarantineWeeklyWorkoutModels.swift
//  Fitly
//
//  Defines @Generable models for a structured weekly quarantine workout response as described by the user.

import Foundation
import FoundationModels

// MARK: - Top-level Weekly Workout Plan (Response)
@Generable
struct QuarantineWeeklyWorkoutPlan: Codable, Equatable {
    @Guide(description: "A brief description of the overall plan and philosophy.")
    var summary: String
    
    @Guide(description: "The list of workout days in this weekly plan, in order.")
    var days: [WorkoutDay1]
    
    @Guide(description: "List of general health and fitness tips relevant to this plan.")
    var tips: [WorkoutTip1]
}

@Generable
struct WorkoutDay1: Codable, Equatable {
    @Guide(description: "Day number or name, e.g. 'Day 1', 'Day 2', or 'Rest Day'.")
    var title: String
    
    @Guide(description: "The main focus or type of this day's workout, e.g. 'Full-Body Strength Training', 'Cardio & Core', 'Rest or Light Activity'.")
    var focus: String
    
    @Guide(description: "Warm-up routine for this day, including time and suggested activities.")
    var warmUp: WorkoutSection1?
    
    @Guide(description: "The main block of the day's workout - exercises, sets, reps, and durations.")
    var mainExercises: [Exercise1]
    
    @Guide(description: "Cool down routine for this day, including time and suggested stretches.")
    var coolDown: WorkoutSection1?
    
    @Guide(description: "Extra notes or advice for this day (optional)")
    var notes: String?
}

@Generable
struct WorkoutSection1: Codable, Equatable {
    @Guide(description: "Summary or name of the section, e.g. 'Warm-Up', 'Cool Down'.")
    var name: String
    
    @Guide(description: "Description or list of activities for the section, e.g. 'Jumping jacks, arm circles, dynamic stretches'.")
    var activities: String
}

@Generable
struct Exercise1: Codable, Equatable {
    @Guide(description: "The name of the exercise, e.g. 'Squats', 'Push-Ups', 'HIIT'.")
    var name: String
    
    @Guide(.range(1...10))
    var sets: Int?
    
    @Guide(description: "Repetitions for each set, e.g. '8-12 reps', '15 reps per side' (optional if duration is specified)")
    var reps: String?
    
    @Guide(description: "Duration per set or activity, e.g. '30 seconds', '20-30 minutes', 'hold for 30-60 seconds' (optional)")
    var duration: String?
    
    @Guide(description: "Any extra instructions or notes for this exercise (optional)")
    var notes: String?
}

@Generable
struct WorkoutTip1: Codable, Equatable {
    @Guide(description: "Short headline of the tip, e.g. 'Hydration', 'Nutrition', 'Progress', etc.")
    var title: String
    
    @Guide(description: "Detailed tip or advice for the user.")
    var details: String
}
