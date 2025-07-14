//
//  GenerateDietPlanUseCase.swift
//  Fitly
//
//  Created by Govind Sah on 14/07/25.
//

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
