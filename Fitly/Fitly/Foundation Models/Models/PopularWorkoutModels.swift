//
//  PopularWorkoutModels.swift
//  Fitly
//
//  Created by Govind Sah on 15/07/25.
//

import FoundationModels

// MARK: - Popular Workout Plan Models for FoundationModel response

@Generable
struct PopularWorkoutPlan {
    @Guide(description: "The title of this plan, e.g., 'General Fitness Plan' or 'HIIT Plan'")
    var title: String

    @Guide(description: "How many days per week this plan should be performed, e.g., '4-5 times per week'")
    var frequency: String

    @Guide(description: "List of days with their details in this workout plan")
    var days: [PopularWorkoutDay]

    @Guide(description: "General tips or advice for this plan, if any")
    var tips: [PopularWorkoutTip]?
}

@Generable
struct PopularWorkoutDay {
    @Guide(description: "The label for this day, e.g., 'Day 1: Full Body Strength Training'")
    var title: String

    @Guide(description: "The recommended warm-up activity for this day")
    var warmup: String?

    @Guide(description: "The main activities or exercises for this day")
    var activities: [PopularWorkoutActivity]?

    @Guide(description: "The recommended cool-down activity for this day")
    var cooldown: String?

    @Guide(description: "Special notes or additional guidance for this day")
    var notes: String?
}

@Generable
struct PopularWorkoutActivity {
    @Guide(description: "The name of the activity or exercise, e.g., 'Squats', 'Jogging'")
    var name: String

    @Guide(description: "Number of sets, if applicable")
    var sets: Int?

    @Guide(description: "Number of reps per set, or a string like '15 reps per side', if applicable")
    var reps: String?

    @Guide(description: "Duration for time-based activities, e.g., '30 seconds', '30-45 minutes'")
    var duration: String?

    @Guide(description: "Additional description for the activity (optional)")
    var description: String?
}

@Generable
struct PopularWorkoutTip {
    @Guide(description: "The category of this tip, e.g., 'Hydration', 'Nutrition', 'Rest', 'Progress'")
    var category: String
    
    @Guide(description: "The tip content")
    var text: String
}

// These models use @Guide for field descriptions and avoid name collision with main workout plan models.
