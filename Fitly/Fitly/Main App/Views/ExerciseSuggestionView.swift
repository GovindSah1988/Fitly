//  ExerciseSuggestionView.swift
//  Fitly
//
//  Created by AI on 14/07/25.
//

import SwiftUI

struct ExerciseSuggestionView: View {

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

    // Callback when description typing animation ends (optional)
    var onTypingComplete: (() -> Void)? = nil
    
    @State private var showSections: Bool = false

    var body: some View {
        ZStack {
            BackgroundGradientView()
            ScrollView {
                
                ReportButtonSection(
                    action: {
                        Task {
                            await viewModel.generateReport()
                        }
                    },
                    isLoading: viewModel.isLoading
                )
                .disabled(viewModel.isGenerating)

                VStack(alignment: .leading, spacing: 20) {
                    
                    if viewModel.isLoading {
                        ProgressView("Generating Excercise Plan Report...")
                            .padding()
                    } else if let error = viewModel.error {
                        Text("Error: \(error)")
                            .foregroundStyle(.red)
                            .padding()
                    } else if let exerciseSuggestion = viewModel.exerciseSuggestion {
                        TypingTextView(
                            fullText: exerciseSuggestion.description,
                            typingSpeed: 20
                        ) {
                            // Reveal sections after description typing
                            withAnimation { showSections = true }
                            onTypingComplete?()
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(lineWidth: 1)
                        )
                        .padding(.horizontal)

                        if showSections {
                            ForEach(Array(exerciseSuggestion.sections.enumerated()), id: \.offset) { idx, section in
                                ExerciseSectionCardView(section: section)
                            }
                        }
                    }

                }
                .padding(.vertical)
            }
        }
    }
}

struct ExerciseSectionCardView: View {
    let section: ExerciseSection
    @State private var showItems: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(section.type.description)
                .font(.title3).bold()
                .foregroundColor(.accentColor)
            TypingTextView(fullText: section.sectionDescription, typingSpeed: 20) {
                // Reveal items after section description
                withAnimation { showItems = true }
            }
            .font(.body)
            .foregroundColor(.secondary)
            if showItems {
                ForEach(Array(section.items.enumerated()), id: \.offset) { idx, item in
                    ExerciseItemView(item: item)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(.systemBackground).opacity(0.75))
                .shadow(radius: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 6).stroke(lineWidth: 1)
        )
        .padding(.horizontal)
        .padding(.bottom, 12)
    }
}

struct ExerciseItemView: View {
    let item: ExerciseItem
    @State private var showDetails: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("• \(item.name)")
                .font(.headline)
            TypingTextView(fullText: item.details, typingSpeed: 20) {
                showDetails = true
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding(.leading)
        .padding(.bottom, 4)
    }
}

//// Preview (requires mock data)
//#if DEBUG
//struct ExerciseSuggestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        let mockItems = [
//            ExerciseItem(name: "Jogging", details: "20 minutes at moderate pace"),
//            ExerciseItem(name: "Jump Rope", details: "3 sets of 2 minutes")
//        ]
//        let mockSection = ExerciseSection(
//            type: .cardiovascular,
//            sectionDescription: "Improve heart health and endurance.",
//            items: mockItems
//        )
//        let suggestion = ExerciseSuggestion(
//            description: "Here's a balanced fitness plan for you.",
//            sections: [mockSection]
//        )
//        ExerciseSuggestionView(exerciseSuggestion: suggestion)
//    }
//}
//#endif
