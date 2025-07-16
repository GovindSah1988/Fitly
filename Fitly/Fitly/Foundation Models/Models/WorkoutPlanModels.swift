//  WorkoutPlanModels.swift
//  Fitly
//
//  Created for generable workout plans using FoundationModels and @Guide

import FoundationModels

@Generable
struct WorkoutPlan2 {
    @Guide(description: "Title of the workout plan, e.g., 'Home Strength & Cardio Workout'.")
    var name: String

    @Guide(description: "Total time required for the workout in minutes, e.g., 60.")
    var totalTimeMinutes: Int

    @Guide(description: "Estimated calories burned during the workout session.")
    var estimatedCalorieBurn: String

    @Guide(description: "List of required equipment for the workout (e.g., Dumbbells, Resistance bands, Mat, Water bottle). If none, use an empty array.")
    var equipmentRequired: [String]

    @Guide(description: "Short summary of the workout's purpose and benefits.")
    var description: String

//    @Guide(description: "Image URL (preferably 4:3) representing this workout, or an appropriate illustration if photo unavailable.")
//    var imageURL: URL?

    @Guide(description: "List of sections in the workout, e.g., Warm-Up, Strength Training, Cardio, Cool Down.")
    var sections: [WorkoutSection2]
}

@Generable
struct WorkoutSection2 {
    @Guide(description: "The name of the section, e.g., 'Warm-Up', 'Strength Training', etc.")
    var title: String

    @Guide(description: "Description of what this section focuses on (e.g., 'Prepares the body', 'Builds muscle', etc.)")
    var sectionDescription: String

    @Guide(description: "List of exercises in this section.")
    var exercises: [WorkoutExercise2]
}

@Generable
struct WorkoutExercise2 {
    @Guide(description: "Exercise name, e.g., 'Bodyweight Squats', 'Push-Ups', etc.")
    var name: String

    @Guide(description: "Number of sets or rounds, if applicable. Use 1 for single-duration exercises.")
    var setsOrRounds: Int

    @Guide(description: "Repetitions per set OR duration per set (e.g., '12-15 reps', '2 minutes').")
    var repetitionsOrDuration: String

    @Guide(description: "Level of difficulty, e.g., Beginner, Intermediate, Expert.")
    var level: String

    @Guide(description: "List of primary benefits of this exercise.")
    var benefits: [String]

    @Guide(description: "Exercise description/instructions.")
    var instructions: String

    @Guide(description: "Target body parts for the exercise, e.g., ['Chest', 'Legs', 'Core'].")
    var targetBodyParts: [String]

//    @Guide(description: "Image URL (preferably 1:1 aspect ratio) for this exercise, or an appropriate illustration if photo unavailable.")
//    var imageURL: URL?
}
