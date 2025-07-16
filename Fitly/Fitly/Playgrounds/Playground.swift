//
//  Playground.swift
//  Fitly
//
//  Created by Govind Sah on 12/07/25.
//

import Playgrounds
import FoundationModels

#Playground {
    
    let workoutDetail = "Each Workout must have name, total time, estimated calorie burn, equipment required, list of excercises with rounds, brief description/benefit, workout image url. Examples of workout are lower body training workout, Quarantine Workout, Cardiovascular (Cardio) Workouts, Strength Training Workouts, Flexibility & Balance Workouts, Mind & Body Workouts, Sport-Specific Workouts, etc"
    
    let exerciseDetail = "Each exercise must have name, repetitions or duration, number of rounds or sets, level(like for for beginner, intermediate, or expert), benefits, description(like 100 pushups a day, 20 situp a day, etc), and target body part(s). Examples of excercise are belly fat burner, loose fat excercise, plank, push up, sit up, knee push up, leg excercises, backward lunge, etc"

    let session = LanguageModelSession(
        instructions: """
            Workout details: \(workoutDetail)
            An excercise's details: \(exerciseDetail)
        """
    )
    
    do {
//        let excercisePrompt = "Find the excercise plan for a male of 35 years of age whose body weight is 79.5 kg, skeletal muscle mass is 33.5 kg, and Body Fat Mass is 20.2 kg, body fat percentage is 25.4%, whose BMI is 26.9 and BMR is 1651 calories per day, Visceral Fat Level is 9. Recommended calory is 2196 kcal, and target weight is 69.8 kg"
//        let workoutPrompt = "Find the workout plan for a male of 35 years of age whose body weight is 79.5 kg, skeletal muscle mass is 33.5 kg, and Body Fat Mass is 20.2 kg, body fat percentage is 25.4%, whose BMI is 26.9 and BMR is 1651 calories per day, Visceral Fat Level is 9. target weight is 69.8 kg. What workout should I do different day a week to help achieve this and yet stay healthy, and fit and strong"
//        let popularWorkoutsPrompt = "Give me some popular workout plans for a female of age range 32 - 37 years of age whose body weight is around 75-80 kg. Maybe also mention the time and calory burnt for each of those workouts. Can we also include the equipment required for each of those workouts? Maybe videos of those workouts as well?"
        
//        let popularWorkoutsPrompt =
//        """
//Give me some popular workout plans for a female of age range 32 - 37 years of age whose body weight is around 75-80 kg. 
//Each of these popular workouts should contain its name, total calory burnt, time required, and brief description of the workout, and actual 4:3 image url for the workout.
//Each of the workouts must collate excercies with same round or set of different exercises in integer, e.g. set required = 8 b) should also contain list of excercises requiring same set.
//Workout example: name = "Lower Body Training", description = "The lower abdomen and hips are the most difficult areas of the body to reduce when we are on a diet. Even so, in this area, especially the legs as a whole, you can reduce weight even if you don't use tools.", duration = 20, unit = minutes,  { setRequired = 8, Excercise
//Each of the exercises should contain a) name b) training duration required for each set in integer e.g. duration = 30 c) training duration unit used e.g. unit = seconds.
//Excercise example: if jumping jacks excercise requires 8 set to be done for 30 seconds, then name = jumping jacks, duration = 30, and unit = seconds. 
//Also, each excercise must contain actual 1:1 image url for the same.
//"""

//        let prompt = """
//            I need a detailed list of popular workout plans, similar to those found in fitness applications. For each workout plan, please provide:
//
//            Workout Plan Title: A clear and concise name (e.g., "Lower Body Training," "Full-Body Strength," "HIIT").
//
//            Workout Type/Focus: A brief description of what the workout targets (e.g., "strength," "cardio," "flexibility," "muscle group specific").
//
//            Estimated Duration: The typical time commitment for the workout (e.g., "30-45 minutes," "60 minutes").
//
//            Estimated Calorie Burn: An approximate range of calories burned per session (e.g., "300-400 kcal," "500+ kcal").
//
//            Equipment Required: A list of any equipment needed (e.g., "Dumbbells (light to medium)," "Resistance bands," "Yoga mat," "None").
//
//            Workout Structure/Rounds:
//
//            A breakdown into main sections (e.g., "Warm-up," "Circuit," "Cool down," "Flow Sequence").
//
//            For each section, list individual exercises or movements.
//
//            Include repetitions or duration for each exercise (e.g., "10 reps," "30 seconds," "15 reps per side").
//
//            Specify the number of rounds or sets if applicable.
//
//            Brief Description/Benefit: A short paragraph explaining the workout's purpose or benefits.
//
//            Target Audience (Optional but helpful): If applicable, specify who the workout might be best suited for (e.g., "beginners," "intermediate," "focus on specific body parts").
//            """

        let specificUserInfo = "a male of 35 years of age whose body weight is 79.5 kg, height is 175 cm, skeletal muscle mass is 33.5 kg, and Body Fat Mass is 20.2 kg, body fat percentage is 25.4%, whose BMI is 26.9 and BMR is 1651 calories per day, Visceral Fat Level is 9. Recommended calory is 2196 kcal, and target weight is 69.8 kg"
        
        let generalUserDemographicInfo = "a male of around 32-37 years of age whose body weight is 75-82 kg, height is 172-178 cm"

        
        let prompt = """
            Can you give best quarantine workout for \(generalUserDemographicInfo) 
            """
        
//        let meal = "today's meal plan "
        let response = try await session.respond(
            to: prompt,
            generating: WorkoutPlan2.self
        )
        print(response.content)
    } catch {
        print("Failed to get response:", error)
    }
}
