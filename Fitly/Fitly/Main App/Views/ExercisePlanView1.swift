//
//  ExercisePlanView1.swift
//  Fitly
//
//  Created by Govind Sah on 14/07/25.
//

import SwiftUI

// MARK: - ExercisePlanView1 and Supporting Views

struct ExercisePlanView1: View {

    @State private var viewModel: ExercisePlanViewModel

    @Environment(LanguageModelManager.self) private var languageModelManager

    let prompt: String

    init(prompt: String, excercisePlanUserCase: DefaultGenerateExercisePlanUseCase) {
        self.prompt = prompt
        // Inject DefaultGenerateExercisePlanUseCase as requested
        _viewModel = State(
            initialValue: ExercisePlanViewModel(
                prompt: prompt,
                generateExercisePlanUseCase: excercisePlanUserCase
            )
        )
    }

    var body: some View {
        ZStack {
            BackgroundGradientView()

            ScrollView {
                VStack {
                    ReportButtonSection(
                        action: {
                            Task {
                                await viewModel.generateReport()
                            }
                        },
                        isLoading: viewModel.isLoading
                    )
                    .disabled(viewModel.isGenerating)

                    if viewModel.isLoading {
                        ProgressView("Generating Excercise Plan Report...")
                            .padding()
                    } else if let error = viewModel.error {
                        Text("Error: \(error)")
                            .foregroundStyle(.red)
                            .padding()
                    } else if let exerciseSuggestion = viewModel.exerciseSuggestion {
                        ExerciseSuggestionDisplayView(
                            exerciseSuggestion: exerciseSuggestion,
                            onTypingComplete: {
                                viewModel.showSectionsAfterTyping()
                            }
                        )

                        if let exerciseSections = viewModel.exerciseSections {
                            ExerciseSectionsListView(exerciseSections: exerciseSections)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

/// Displays the main description of the ExerciseSuggestion with typing animation.
/// Calls onTypingComplete after the main description finishes typing.
struct ExerciseSuggestionDisplayView: View {
    let exerciseSuggestion: ExerciseSuggestion // Assuming it has 'description' property
    let onTypingComplete: () -> Void

    var body: some View {
        TypingTextView(fullText: exerciseSuggestion.description, typingSpeed: 15) {
            onTypingComplete()
        }
        .padding()
        .overlay(
            alignment: .leading,
            content: {
                RoundedRectangle(cornerRadius: 2)
                    .stroke(lineWidth: 1)
            }
        )
        .padding()
    }
}

/// Displays a list of ExerciseSections,
/// Each section shows its sectionDescription and its items with typing animation.
struct ExerciseSectionsListView: View {
    let exerciseSections: [ExerciseSection]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(Array(exerciseSections.enumerated()), id: \.offset) { _, section in
                VStack(alignment: .leading, spacing: 8) {
                    Text(section.sectionDescription)
                        .font(.headline)
                        .padding(.bottom, 4)

                    ForEach(Array(section.items.enumerated()), id: \.offset) { _, item in
                        TypingTextView(fullText: item.details, typingSpeed: 15)
                            .padding(.leading)
                    }
                }
                .padding()
                .overlay(
                    alignment: .leading,
                    content: {
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(lineWidth: 1)
                    }
                )
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}
