//
//  SurveyView1.swift
//  Fitly
//
//  Created by Govind Sah on 13/07/25.
//

import SwiftUI

struct SurveyView1: View {

    // ViewModel instance, observing its changes
    @State private var viewModel: SurveyViewModel

    // The LanguageModelManager is passed to the ViewModel, not directly accessed by the View's body now.
    // However, since it's an @Environment object, we still need to provide it to the ViewModel.
    @Environment(LanguageModelManager.self) private var languageModelManager

    // Better approach for SurveyView init:
    let prompt: String

    // **IMPORTANT:** Correct way to inject Environment object into ViewModel init
    // Use an initializer with @Environment to properly get the languageModelManager
    // This requires a minor adjustment to how the ViewModel is initialized when using @Environment.
    init(prompt: String, generateDietPlanUseCase: GenerateDietPlanUseCase) {
        self.prompt = prompt
        _viewModel = State(
            initialValue: SurveyViewModel(
                prompt: prompt,
                generateDietPlanUseCase: generateDietPlanUseCase
            )
        )
    }

    var body: some View {
        ZStack {
            BackgroundGradientView() // Modularized background

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
                    // Disable the button based on viewModel.isGenerating
                    .disabled(viewModel.isGenerating)

                    if viewModel.isLoading {
                        ProgressView("Generating Report...")
                            .padding()
                    } else if let error = viewModel.error {
                        Text("Error: \(error)")
                            .foregroundStyle(.red)
                            .padding()
                    } else if let dietSuggestion = viewModel.dietSuggestion {
                        // Pass the diet suggestion from the ViewModel
                        DietSuggestionDisplayView(
                            dietSuggestion: dietSuggestion,
                            onTypingComplete: {
                                viewModel.showMealSuggestionsAfterTyping() // Call ViewModel method
                            }
                        )

                        if let mealSuggestions = viewModel.mealSuggestions {
                            MealSuggestionsListView(mealSuggestions: mealSuggestions)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct MealSuggestionsListView: View {
    let mealSuggestions: [MealSuggestionsWithCaloriesDetails]

    var body: some View {
        ForEach(Array(mealSuggestions.enumerated()), id: \.offset) { index, suggestion in
            VStack(alignment: .leading) { // Align content to leading
                Text(suggestion.meal.nameAndCalories)
                    .font(.headline) // Make meal name stand out
                    .padding(.bottom, 5)

                ForEach(suggestion.meal.mealItems, id: \.name) { mealItem in // Assuming MealItem has a 'name' property as ID
                    TypingTextView(fullText: mealItem.nameAndCalory, typingSpeed: 15)
                        .padding(.leading) // Indent meal items
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
            .padding(.horizontal) // Add horizontal padding for separation
            .padding(.bottom, 10) // Add some space between meal blocks
        }
    }
}

struct DietSuggestionDisplayView: View {
    let dietSuggestion: DietSuggestion // Assuming DietSuggestion has a 'description' property
    let onTypingComplete: () -> Void // Callback to trigger meal suggestions display

    var body: some View {
        TypingTextView(fullText: dietSuggestion.description, typingSpeed: 15) {
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

struct ReportButtonSection: View {
    @Environment(LanguageModelManager.self) var languageModelManager
    let action: () -> Void
    let isLoading: Bool

    var body: some View {
        VStack {
            Button("Get report") {
                action()
            }
            .buttonStyle(.borderedProminent)
            .disabled(isLoading || languageModelManager.isResponding) // Disable button while loading or LM is responding
        }
        .padding(.vertical) // Add some padding around the button section
    }
}

struct BackgroundGradientView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.blue.opacity(0.2),
                    Color.purple.opacity(0.2)
                ]
            ),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)
    }
}
