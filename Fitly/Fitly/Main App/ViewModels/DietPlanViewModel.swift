//
//  DietPlanViewModel.swift
//  Fitly
//
//  Created by Govind Sah on 13/07/25.
//

import SwiftUI

@Observable
final class DietPlanViewModel {
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
        if let dietSuggestion {
            self.mealSuggestions = dietSuggestion.mealSuggestions
        }
    }
}
