import Foundation

// Protocol for generating or retrieving a WorkoutPlan
protocol GenerateWorkoutPlanUseCase {
    var isResponding: Bool { get }
    func execute(prompt: String) async throws -> WorkoutPlan
}

class DefaultGenerateWorkoutPlanUseCase: GenerateWorkoutPlanUseCase {
    
    private let languageModelManager: LanguageModelManager

    var isResponding: Bool {
        languageModelManager.isResponding
    }

    init(languageModelManager: LanguageModelManager) {
        self.languageModelManager = languageModelManager
    }

    func execute(prompt: String) async throws -> WorkoutPlan {
        // This is where the business logic resides:
        // 1. Potentially transform the prompt further for the LM.
        // 2. Call the language model manager.
        let rawResponse = try await languageModelManager.generateResponse(
            for: prompt,
            generating: WorkoutPlan.self // Or maybe a more raw LM response type, then transform it here
        )
        // 3. Apply any post-processing business rules to the raw response
        //    before returning the final DietSuggestion model.
        //    E.g., validate calories, ensure all meals are present,
        //    apply dietary restrictions not handled by the LM directly.
        return rawResponse
    }
}

// MARK: - Sample/mock implementation for demo/testing
final class MockGenerateWorkoutPlanUseCase: GenerateWorkoutPlanUseCase {
    private(set) var isResponding: Bool = false
    
    func execute(prompt: String) async throws -> WorkoutPlan {
        isResponding = true
        defer { isResponding = false }
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_500_000_000)
        
        // Return a sample plan (could be improved as needed)
        return WorkoutPlan(
            days: [
                WorkoutDay(
                    title: "Day 1: Full Body Strength Training",
                    warmUp: "5-10 minutes of dynamic stretches",
                    activities: [
                        .exercise(Exercise(name: "Squats", sets: 4, reps: "8-12 reps", duration: nil, notes: nil)),
                        .exercise(Exercise(name: "Deadlifts", sets: 4, reps: "8-12 reps", duration: nil, notes: nil)),
                        .exercise(Exercise(name: "Bench Press", sets: 3, reps: "8-12 reps", duration: nil, notes: nil)),
                        .exercise(Exercise(name: "Bent-over Rows", sets: 3, reps: "8-12 reps", duration: nil, notes: nil)),
                        .exercise(Exercise(name: "Pull-ups", sets: 3, reps: "8-12 reps", duration: nil, notes: "Or Assisted Pull-ups")),
                        .exercise(Exercise(name: "Planks", sets: 3, reps: nil, duration: "30-60 seconds", notes: nil)),
                    ],
                    notes: nil
                ),
                // ...Other days could be added
            ],
            tips: [
                WorkoutTip(category: "Nutrition", text: "Focus on a balanced diet with adequate protein."),
                WorkoutTip(category: "Hydration", text: "Stay well-hydrated throughout the day."),
                WorkoutTip(category: "Sleep", text: "Aim for 7-9 hours of quality sleep per night."),
                WorkoutTip(category: "Monitor Progress", text: "Keep track of your workouts and progress."),
            ]
        )
    }
}
