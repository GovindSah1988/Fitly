//
//  SurveyViewModel.swift
//  Fitly
//
//  Created by Govind Sah on 13/07/25.
//

import SwiftUI

protocol GenerateDietPlanUseCase {
    var isResponding: Bool { get }
    func execute(prompt: String) async throws -> DietSuggestion
}

class DefaultGenerateDietPlanUseCase: GenerateDietPlanUseCase {
    
    private let languageModelManager: LanguageModelManager

    var isResponding: Bool {
        languageModelManager.isResponding
    }

    init(languageModelManager: LanguageModelManager) {
        self.languageModelManager = languageModelManager
    }

    func execute(prompt: String) async throws -> DietSuggestion {
        // This is where the business logic resides:
        // 1. Potentially transform the prompt further for the LM.
        // 2. Call the language model manager.
        let rawResponse = try await languageModelManager.generateResponse(
            for: prompt,
            generating: DietSuggestion.self // Or maybe a more raw LM response type, then transform it here
        )
        // 3. Apply any post-processing business rules to the raw response
        //    before returning the final DietSuggestion model.
        //    E.g., validate calories, ensure all meals are present,
        //    apply dietary restrictions not handled by the LM directly.
        return rawResponse
    }
}

@Observable
final class SurveyViewModel {
    // MARK: - Published Properties (or just properties with @Published for ObservableObject)
    var dietSuggestion: DietSuggestion?
    var mealSuggestions: [MealSuggestionsWithCaloriesDetails]?
    var isLoading: Bool = false
    var error: String?
    
    // Internal state, not directly exposed to view but impacts view's enablement
    var isGenerating: Bool { isLoading || generateDietPlanUseCase.isResponding }
    
    // Dependencies
    private let prompt: String
    private let generateDietPlanUseCase: GenerateDietPlanUseCase // Dependency on the Use Case protocol
    
    init(prompt: String, generateDietPlanUseCase: GenerateDietPlanUseCase) {
        self.prompt = prompt
        self.generateDietPlanUseCase = generateDietPlanUseCase
    }
    
    @MainActor
    func generateReport() async {
        isLoading = true
        error = nil
        dietSuggestion = nil
        mealSuggestions = nil
        
        do {
            // Call the Use Case, not the LanguageModelManager directly
            let response = try await generateDietPlanUseCase.execute(prompt: prompt)
            self.dietSuggestion = response
        } catch {
            self.error = error.localizedDescription
            print("Error generating report: \(error)")
        }
        
        isLoading = false
    }
    
    // This method is called by the DietSuggestionDisplayView when its typing animation finishes.
    @MainActor
    func showMealSuggestionsAfterTyping() {
        if let dietSuggestion = dietSuggestion {
            self.mealSuggestions = dietSuggestion.mealSuggestions
        }
    }
}
