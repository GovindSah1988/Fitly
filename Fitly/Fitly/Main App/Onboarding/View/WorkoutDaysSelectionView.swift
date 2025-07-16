//
//  WorkoutDaysSelectionView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 14/07/25.
//

import SwiftUI

struct WorkoutDaysSelectionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    let items = [
        SelectionItem(title: "Monday"),
        SelectionItem(title: "Tuesday"),
        SelectionItem(title: "Wednesday"),
        SelectionItem(title: "Thursday"),
        SelectionItem(title: "Friday"),
        SelectionItem(title: "Saturday"),
        SelectionItem(title: "Sunday")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What days would you like to workout?")
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
    WorkoutDaysSelectionView(viewModel: OnboardingViewModel())
}
