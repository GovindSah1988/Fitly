//
//  MedicalConditionInfoView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 14/07/25.
//
import SwiftUI

struct MedicalConditionInfoView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    let items = [
        SelectionItem(title: "Diabetes"),
        SelectionItem(title: "Heart conditions"),
        SelectionItem(title: "Joint problems"),
        SelectionItem(title: "Asthma"),
        SelectionItem(title: "Other health concerns")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Do you have any medical conditions or physical limitations that we should be aware of?")
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
    MedicalConditionInfoView(viewModel: OnboardingViewModel())
}
