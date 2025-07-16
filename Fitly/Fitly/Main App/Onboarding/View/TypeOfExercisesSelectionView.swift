//
//  TypeOfExercisesSelectionView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 14/07/25.
//

import SwiftUI

struct TypeOfExercisesSelectionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    let items = [
        SelectionItem(title: "Strength Training", systemImage: "dumbbell"),
        SelectionItem(title: "Strength Training + Cardio", systemImage: "figure.strengthtraining.traditional"),
        SelectionItem(title: "Cardio", systemImage: "figure.run.treadmill"),
        SelectionItem(title: "Yoga or Pilates", systemImage: "figure.yoga"),
        SelectionItem(title: "HIIT (High-intensity interval training)", systemImage: "figure.highintensity.intervaltraining"),
        SelectionItem(title: "Other", systemImage: "person.fill.questionmark")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What type of exercises do you enjoy??")
                .font(.title2)
                .bold()

            CardSelectionView(selectedItem: $viewModel.selectedGoal, items: items)
            
            if viewModel.selectedGoal == items.last?.title {
                UnderlineTextField(
                        title: "If Other, please specify",
                        placeholder: "",
                        suffix: "",
                        text: .constant(""),
                        keyboardType: .numberPad
                    )
            }
        }
    }
}

#Preview {
    TypeOfExercisesSelectionView(viewModel: OnboardingViewModel())
}
