//
//  GenerateExercisePlanUseCase.swift
//  Fitly
//
//  Created by Govind Sah on 14/07/25.
//

protocol GenerateExercisePlanUseCase {
    var isResponding: Bool { get }
    func execute(prompt: String) async throws -> ExerciseSuggestion
}

class DefaultGenerateExercisePlanUseCase: GenerateExercisePlanUseCase {
    private let languageModelManager: LanguageModelManager
    
    var isResponding: Bool {
        languageModelManager.isResponding
    }

    init(languageModelManager: LanguageModelManager) {
        self.languageModelManager = languageModelManager
    }

    func execute(prompt: String) async throws -> ExerciseSuggestion {
        let rawResponse = try await languageModelManager.generateResponse(
            for: prompt,
            generating: ExerciseSuggestion.self
        )
        return rawResponse
    }
}

