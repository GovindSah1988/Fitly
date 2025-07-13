//
//  SurveyView.swift
//  Fitly
//
//  Created by Govind Sah on 12/07/25.
//

import SwiftUI

struct SurveyView: View {
    
    @Environment(LanguageModelManager.self) var languageModelManager

    let prompt: String
    
    @State var dietSuggestion: DietSuggestion?
    @State var mealSuggestions: [MealSuggestionsWithCaloriesDetails]?

    @State private var isLoading: Bool = false
    @State private var error: String? = nil

    var body: some View {
        
        ZStack {
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
            
            ScrollView {
                Button("Get report") {
                    Task {
                        isLoading = true
                        error = nil

                        do {
                            let response = try await languageModelManager.generateResponse(
                                for: prompt,
                                generating: DietSuggestion.self
                            )
                            dietSuggestion = response
                        } catch {
                            self.error = error.localizedDescription
                            print(error)
                        }
                        
                        isLoading = false
                    }
                }
                .disabled(languageModelManager.isResponding)
                
                if isLoading {
                    ProgressView()
                } else if let error = error {
                    Text("Error: \(error)")
                        .foregroundStyle(.red)
                } else if let dietSuggestion {
                    TypingTextView(fullText: dietSuggestion.description, typingSpeed: 15) {
                        mealSuggestions = dietSuggestion.mealSuggestions
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
                    
                    if let mealSuggestions {
                        ForEach(Array(mealSuggestions.enumerated()), id: \.offset) { index, suggestion in
                            VStack {
                                Text(suggestion.meal.nameAndCalories)
                                
                                ForEach(suggestion.meal.mealItems, id: \.name) { mealItem in
                                    TypingTextView(fullText: mealItem.nameAndCalory, typingSpeed: 15)
                                        .padding()
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 2)
//                                                .stroke(lineWidth: 1)
//                                        )
//                                        .padding()
                                }
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 2)
//                                        .stroke(lineWidth: 1)
//                                )
//                                .padding()

                            }
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
                }
            }
        }
    }
}
