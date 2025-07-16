//
//  WorkoutEnvironmentSelectionView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 14/07/25.
//

import SwiftUI

struct WorkoutEnvironmentSelectionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    let items = [
        SelectionItem(title: "Home", systemImage: "house.fill"),
        SelectionItem(title: "Gym", systemImage: "dumbbell"),
        SelectionItem(title: "Outdoors", icon: "outdoors")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What is your preferred workout environment?")
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
    WorkoutEnvironmentSelectionView(viewModel: OnboardingViewModel())
}
