//
//  ActivityLevelSelectionView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 13/07/25.
//

import SwiftUI

struct ActivityLevelSelectionView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    let items = [
        SelectionItem(title: "Sedentary", subTitle: "I do almost no exercise", icon: "activity_0"),
        SelectionItem(title: "Slightly Active", subTitle: "I exercise up to 2 hours in a week", icon: "activity_1"),
        SelectionItem(title: "Moderately Active", subTitle: "I exercise up to 4 hours in a week", icon: "activity_2"),
        SelectionItem(title: "Very Active", subTitle: "I exercise for 4+ hours in a week", icon: "activity_3")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What is your activity level?")
                .font(.title2)
                .bold()
            
            Text("This helps us design your workouts to fit your lifestyle")
                .foregroundColor(.secondary)
                .font(.footnote)
            
            CardSelectionView(selectedItem: $viewModel.selectedGoal, items: items)
        }
    }
}

#Preview {
    ActivityLevelSelectionView(viewModel: OnboardingViewModel())
}
