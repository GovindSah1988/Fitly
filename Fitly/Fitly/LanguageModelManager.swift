//
//  LanguageModelManager.swift
//  Fitly
//
//  Created by Govind Sah on 13/07/25.
//

import FoundationModels
import Observation // For @Observable in iOS 17+ / Swift 5.9+

// If LanguageModelSession itself is not an ObservableObject or does not use @Observable
@Observable
class LanguageModelManager {
    private let session: LanguageModelSession

    init() {
        self.session = LanguageModelSession(
            instructions: """
        You are a diet and fitness expert.
        """
        )
    }

    // Add methods to interact with the session
    func generateResponse<Content: Generable>(
        for prompt: String,
        generating type: Content.Type = Content.self,
        includeSchemaInPrompt: Bool = true,
        options: GenerationOptions = GenerationOptions(),
        isolation: isolated (any Actor)? = #isolation
    ) async throws -> sending Content {
        let result = try await session.respond(
            to: prompt,
            generating: type,
            includeSchemaInPrompt: includeSchemaInPrompt,
            options: options,
            isolation: isolation
        )

        print(result.content)

        // Process the result
        return result.content
    }

    var isResponding: Bool {
        session.isResponding
    }
}
