import Foundation
import Observation

@Observable
final class WorkoutPlanViewModel {
    var workoutPlan: WorkoutPlan?
    var isLoading: Bool = false
    var error: String?
    var isGenerating: Bool { useCase.isResponding }

    private let prompt: String
    private let useCase: GenerateWorkoutPlanUseCase

    init(prompt: String, useCase: GenerateWorkoutPlanUseCase) {
        self.prompt = prompt
        self.useCase = useCase
    }

    @MainActor
    func generatePlan() async {
        error = nil
        isLoading = true
        do {
            self.workoutPlan = try await useCase.execute(prompt: prompt)
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
