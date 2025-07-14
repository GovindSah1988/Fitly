//
//  SurveyData.swift
//  Fitly
//
//  Created by Govind Sah on 13/07/25.
//

import Foundation

// Models/SurveyData.swift
struct SurveyData: Codable { // Make it Codable if you need to save/load progress
    var userName: String = ""
    var age: Int?
    var heightCm: Int?
    var weightKg: Int?
    var dietaryPreferences: Set<String> = [] // e.g., "Vegetarian", "Vegan", "Gluten-Free"
    var allergies: Set<String> = [] // e.g., "Peanuts", "Dairy"
    var fitnessGoals: String = "" // e.g., "Muscle Gain", "Weight Loss", "Endurance"

    // Add more fields as needed for your survey
    var summaryPrompt: String = ""
}


// ViewModels/SurveyFlowCoordinator.swift
import Foundation
import Observation // For @Observable

@Observable
final class SurveyFlowCoordinator {
    var currentSurveyData: SurveyData = SurveyData() // The accumulated data

    // Navigation state (optional, for controlling active views in a NavigationView/Tab)
    // For a simple linear flow, you might just use a presentation manager or direct navigation.
    enum SurveyStep: Identifiable, CaseIterable { // Example steps
        case welcome
        case demographics
        case dietary
        case fitnessGoals
        case summary // The step before final generation
        case result // Where SurveyView would be presented

        var id: Self { self }
        // Add titles or other properties if needed for navigation UI
    }

    // You might manage the active path in a NavigationStack for iOS 16+
    var navigationPath = [SurveyStep]()

    // This is the property that will generate the final prompt
    var finalPrompt: String {
        var components: [String] = []

        if !currentSurveyData.userName.isEmpty {
            components.append("My name is \(currentSurveyData.userName).")
        }
        if let age = currentSurveyData.age {
            components.append("I am \(age) years old.")
        }
        if let height = currentSurveyData.heightCm, let weight = currentSurveyData.weightKg {
            components.append("My height is \(height) cm and my weight is \(weight) kg.")
        }
        if !currentSurveyData.dietaryPreferences.isEmpty {
            let prefs = currentSurveyData.dietaryPreferences.joined(separator: ", ")
            components.append("My dietary preferences include: \(prefs).")
        }
        if !currentSurveyData.allergies.isEmpty {
            let aller = currentSurveyData.allergies.joined(separator: ", ")
            components.append("I have allergies to: \(aller).")
        }
        if !currentSurveyData.fitnessGoals.isEmpty {
            components.append("My primary fitness goal is \(currentSurveyData.fitnessGoals).")
        }

        // You can add more complex logic here to form a very specific prompt
        return "Based on my profile: \(components.joined(separator: " ")) Please generate a comprehensive diet plan and meal suggestions."
    }

    // Methods to update survey data from individual steps (or views can bind directly)
    func updateUserName(_ name: String) { currentSurveyData.userName = name }
    func updateDemographics(age: Int?, height: Int?, weight: Int?) {
        currentSurveyData.age = age
        currentSurveyData.heightCm = height
        currentSurveyData.weightKg = weight
    }
    // ... similar methods for other data points

    // Methods for navigation (optional, depending on how you manage flow)
    func goToNextStep() {
        // Implement logic to push to next view based on current path
        // e.g., navigationPath.append(SurveyStep.demographics)
    }

    func goToResult() {
        navigationPath.append(.result)
    }
}


import SwiftUI

struct DemographicsSurveyView: View {
    // Option A: Binding to SurveyData (preferred for simple forms)
    @Binding var surveyData: SurveyData
    var onNext: () -> Void // Callback to tell parent to navigate

    // Option B: Taking the coordinator directly (for more complex flow logic)
    // @EnvironmentObject var coordinator: SurveyFlowCoordinator // For ObservableObject
    // @Environment(SurveyFlowCoordinator.self) var coordinator: SurveyFlowCoordinator // For @Observable

    @State private var ageInput: String = ""
    @State private var heightInput: String = ""
    @State private var weightInput: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Tell us about yourself")
                .font(.title)

            TextField("Age", text: $ageInput)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .onAppear { ageInput = surveyData.age.map(String.init) ?? "" }

            TextField("Height (cm)", text: $heightInput)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .onAppear { heightInput = surveyData.heightCm.map(String.init) ?? "" }

            TextField("Weight (kg)", text: $weightInput)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .onAppear { weightInput = surveyData.weightKg.map(String.init) ?? "" }

            Button("Next") {
                surveyData.age = Int(ageInput)
                surveyData.heightCm = Int(heightInput)
                surveyData.weightKg = Int(weightInput)
                onNext() // Tell the parent to move to the next step
            }
            .buttonStyle(.borderedProminent)
            .disabled(ageInput.isEmpty || heightInput.isEmpty || weightInput.isEmpty)
        }
        .padding()
        .navigationTitle("Demographics")
    }
}

// Example of another step
struct FitnessGoalsSurveyView: View {
    @Binding var surveyData: SurveyData
    var onNext: () -> Void

    @State private var goal: String = ""

    var body: some View {
        VStack {
            Text("What are your fitness goals?")
            TextField("e.g., Muscle Gain, Weight Loss", text: $goal)
                .textFieldStyle(.roundedBorder)
                .onAppear { goal = surveyData.fitnessGoals }

            Button("Next") {
                surveyData.fitnessGoals = goal
                onNext()
            }
            .disabled(goal.isEmpty)
        }
        .padding()
        .navigationTitle("Goals")
    }
}


import SwiftUI

struct TabBarView1: View {
    let languageModelManager: LanguageModelManager

    var body: some View {
        TabView {
            // Survey Tab
            SurveyFlowNavigationView(languageModelManager: languageModelManager)
                .tabItem {
                    Label("Survey", systemImage: "questionmark.circle.fill")
                }

            // Other Tab
            NavigationView {
                Text("Dashboard Content")
                    .navigationTitle("Dashboard")
            }
            .tabItem {
                Label("Dashboard", systemImage: "gauge.open.with.lines.needle.33percent")
            }
        }
    }
}

// SurveyFlowNavigationView.swift (The container for the multi-step survey)
import SwiftUI

struct SurveyFlowNavigationView: View {
    @State private var coordinator: SurveyFlowCoordinator
    let languageModelManager: LanguageModelManager // Passed from MyApp/TabBarView

    init(languageModelManager: LanguageModelManager) {
        self.languageModelManager = languageModelManager
        _coordinator = State(initialValue: SurveyFlowCoordinator())
    }

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            // Start of the flow
            WelcomeSurveyView(onNext: {
                coordinator.navigationPath.append(.demographics)
            })
            .navigationDestination(for: SurveyFlowCoordinator.SurveyStep.self) { step in
                switch step {
                case .welcome:
                    WelcomeSurveyView(onNext: { coordinator.navigationPath.append(.demographics) })
                case .demographics:
                    DemographicsSurveyView(surveyData: $coordinator.currentSurveyData) {
                        coordinator.navigationPath.append(.dietary)
                    }
                case .dietary:
                    DietaryPreferencesSurveyView(surveyData: $coordinator.currentSurveyData) {
                        coordinator.navigationPath.append(.fitnessGoals)
                    }
                case .fitnessGoals:
                    FitnessGoalsSurveyView(surveyData: $coordinator.currentSurveyData) {
                        coordinator.navigationPath.append(.summary)
                    }
                case .summary:
                    SurveySummaryView(surveyData: coordinator.currentSurveyData) {
                        coordinator.goToResult() // Navigate to the final result view
                    }
                case .result:
                    // Here's where the final SurveyView is presented
                    // It gets the composed prompt from the coordinator
                    let generateDietPlanUseCase = DefaultGenerateDietPlanUseCase(languageModelManager: languageModelManager)
                    DietPlanView1(prompt: coordinator.finalPrompt, generateDietPlanUseCase: generateDietPlanUseCase)
                }
            }
            .navigationTitle("Welcome")
        }
    }
}

// Dummy views for other steps (you'd implement these fully)
struct WelcomeSurveyView: View {
    var onNext: () -> Void
    @State private var name: String = ""
    var body: some View {
        VStack {
            Text("Welcome! What's your name?")
            TextField("Your Name", text: $name)
                .textFieldStyle(.roundedBorder)
            Button("Start") { onNext() }
                .disabled(name.isEmpty)
        }
        .onDisappear {
            // If you passed the coordinator directly, you'd update here:
            // coordinator.updateUserName(name)
            // Or if binding, it's already updated.
        }
    }
}
struct DietaryPreferencesSurveyView: View {
    @Binding var surveyData: SurveyData
    var onNext: () -> Void
    var body: some View {
        VStack {
            Text("Dietary Preferences")
            // ... input for preferences, update surveyData
            Button("Next") { onNext() }
        }
    }
}
struct SurveySummaryView: View {
    let surveyData: SurveyData // Read-only summary
    var onNext: () -> Void
    var body: some View {
        VStack {
            Text("Summary of your input:")
            Text(surveyData.summaryPrompt) // If SurveyData had a summaryPrompt property
            Button("Generate Report") { onNext() }
        }
    }
}
