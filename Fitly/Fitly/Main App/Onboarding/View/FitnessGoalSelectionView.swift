//
//  FitnessGoalSelectionView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 13/07/25.
//

import SwiftUI

struct FitnessGoalSelectionView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    let items = [
        SelectionItem(title: "Lose Weight", icon: "goal_lose"),
        SelectionItem(title: "Build Strength", icon: "goal_strength"),
        SelectionItem(title: "Gain Weight", icon: "goal_gain"),
        SelectionItem(title: "Reduce Stress", icon: "goal_stress"),
        SelectionItem(title: "Improve Health", icon: "goal_health")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("What is your fitness goal?")
                .font(.title2)
                .bold()
            
            Text("Knowing your goals help us tailor your experience")
                .foregroundColor(.secondary)
                .font(.footnote)
            
            CardSelectionView(selectedItem: $viewModel.selectedGoal, items: items)
        }
    }
}

#Preview {
    FitnessGoalSelectionView(viewModel: OnboardingViewModel())
}
