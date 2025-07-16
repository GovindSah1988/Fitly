//
//  CommitedWorkoutTimeSelectionView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 14/07/25.
//

import SwiftUI

struct CommitedWorkoutTimeSelectionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    let items = [
        SelectionItem(title: "Less than 30 minutes"),
        SelectionItem(title: "30-60 minutes"),
        SelectionItem(title: "More than 60 minutes")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("How much time can you commit to exercise?")
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
    CommitedWorkoutTimeSelectionView(viewModel: OnboardingViewModel())
}
