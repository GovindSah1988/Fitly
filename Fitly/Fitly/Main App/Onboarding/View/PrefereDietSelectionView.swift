//
//  PreferDietSelectionView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 14/07/25.
//

import SwiftUI

struct PreferDietSelectionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    let items = [
        SelectionItem(title: "Vegetarian"),
        SelectionItem(title: "Eggitarian"),
        SelectionItem(title: "Non-Vegetarian")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Select your Meal Preference?")
                .font(.title2)
                .bold()

            CardSelectionView(selectedItem: $viewModel.selectedGoal, items: items)
        }
    }
}

#Preview {
    PreferDietSelectionView(viewModel: OnboardingViewModel())
}
