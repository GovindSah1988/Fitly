//
//  OnboardingViewModel.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 13/07/25.
//

import SwiftUI
import Combine

enum OnboardingStep: Int, CaseIterable, Equatable {
    case personalInfo
    case fitnessGoal
    case activityLevel
    case medicalInfo
    case workoutEnvironment
    case typeOfExcersice
    case commitedWorkoutTime
    case preferworkoutDays
    case preferworkoutTime
    case preferDiet
}

class OnboardingViewModel: ObservableObject {
    // Step index
    @Published var currentStep: OnboardingStep = .personalInfo

    // Personal info
    @Published var gender: String = ""
    @Published var age: String = ""
    @Published var weight: String = ""
    @Published var height: String = ""
    @Published var weightUnit: String = "KG"
    @Published var heightUnit: String = "CM"

    // Goals
    @Published var selectedGoal: String = ""
    @Published var selectedActivity: String = ""
    
    var steps: [OnboardingStep] {
        OnboardingStep.allCases
    }
    
    var currentStepIndex: Int {
        steps.firstIndex(of: currentStep) ?? 0
    }
    
    // Navigation
    var isLastStep: Bool {
        currentStep == OnboardingStep.allCases.last
    }

    func next() {
        if let nextIndex = OnboardingStep.allCases.firstIndex(of: currentStep)?.advanced(by: 1),
           nextIndex < OnboardingStep.allCases.count {
            currentStep = OnboardingStep.allCases[nextIndex]
        }
    }

    func back() {
        if let prevIndex = OnboardingStep.allCases.firstIndex(of: currentStep)?.advanced(by: -1),
           prevIndex >= 0 {
            currentStep = OnboardingStep.allCases[prevIndex]
        }
    }
}
