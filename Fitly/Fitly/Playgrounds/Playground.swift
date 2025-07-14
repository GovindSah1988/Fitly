//
//  Playground.swift
//  Fitly
//
//  Created by Govind Sah on 12/07/25.
//

import Playgrounds
import FoundationModels

#Playground {
    let session = LanguageModelSession()
    
    do {
//        let response = try await session.respond(to: "Find the excercise plan for a male of 35 years of age whose body weight is 79.5 kg, skeletal muscle mass is 33.5 kg, and Body Fat Mass is 20.2 kg, body fat percentage is 25.4%, whose BMI is 26.9 and BMR is 1651 calories per day, Visceral Fat Level is 9. Recommended calory is 2196 kcal, and target weight is 69.8 kg")
        
        let response = try await session.respond(to: "Find the workout plan for a male of 35 years of age whose body weight is 79.5 kg, skeletal muscle mass is 33.5 kg, and Body Fat Mass is 20.2 kg, body fat percentage is 25.4%, whose BMI is 26.9 and BMR is 1651 calories per day, Visceral Fat Level is 9. target weight is 69.8 kg. What workout should I do different day a week to help achieve this and yet stay healthy, and fit and strong")

        print(response.content)
    } catch {
        print("Failed to get response:", error)
    }
}
