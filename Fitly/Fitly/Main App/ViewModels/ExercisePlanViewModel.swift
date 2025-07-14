//  ExercisePlanViewModel.swift
//  Fitly
//  Created by AI Assistant on 14/07/25.

import SwiftUI

@Observable
final class ExercisePlanViewModel {
    // MARK: - Published Properties
    var exerciseSuggestion: ExerciseSuggestion?
    var exerciseSections: [ExerciseSection]?
    var isLoading: Bool = false
    var error: String?

    var isGenerating: Bool { isLoading || generateExercisePlanUseCase.isResponding }
    
    private let prompt: String
    private let generateExercisePlanUseCase: GenerateExercisePlanUseCase

    init(prompt: String, generateExercisePlanUseCase: GenerateExercisePlanUseCase) {
        self.prompt = prompt
        self.generateExercisePlanUseCase = generateExercisePlanUseCase
    }

    @MainActor
    func generateReport() async {
        isLoading = true
        error = nil
        exerciseSuggestion = nil
        
        do {
            let response = try await generateExercisePlanUseCase.execute(prompt: prompt)
            self.exerciseSuggestion = response
        } catch {
            self.error = error.localizedDescription
            print("Error generating exercise report: \(error)")
        }
        isLoading = false
    }

    // This method is called by the DietSuggestionDisplayView when its typing animation finishes.
    @MainActor
    func showSectionsAfterTyping() {
        if let exerciseSuggestion {
            self.exerciseSections = exerciseSuggestion.sections
        }
    }
}

