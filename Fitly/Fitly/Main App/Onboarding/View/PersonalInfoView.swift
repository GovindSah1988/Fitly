//
//  PersonalInfoView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 13/07/25.
//

import SwiftUI

struct PersonalInfoView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Hello Adrian!")
                .font(.title)
                .bold()
            
            Text("Tell us more about you..")
                .font(.title3)
                .bold()

            // Gender
            Text("Select your gender")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 12) {
                SelectableCardView(title: "Male", iconName: "maleIcon", isSelected: viewModel.gender == "Male") {
                    viewModel.gender = "Male"
                }
                SelectableCardView(title: "Female", iconName: "femaleIcon", isSelected: viewModel.gender == "Female") {
                    viewModel.gender = "Female"
                }
            }

            // Age
            UnderlineTextField(
                    title: "Age",
                    placeholder: "Enter age",
                    suffix: "years",
                    text: $viewModel.age,
                    keyboardType: .numberPad
                )

            // Weight
            HStack(spacing: 8) {
                UnderlineTextField(
                        title: "Weight",
                        placeholder: "Enter Weight",
                        suffix: "",
                        text: $viewModel.age,
                        keyboardType: .numberPad
                    )
                CustomSegmentedToggle(
                    selected: $viewModel.weightUnit,
                    options: ["KG", "LB"])
                .frame(width: 100)
            }

            // Height
            HStack(spacing: 8) {
                UnderlineTextField(
                        title: "Height",
                        placeholder: "Enter Height",
                        suffix: "",
                        text: $viewModel.age,
                        keyboardType: .numberPad
                    )
                CustomSegmentedToggle(
                    selected: $viewModel.heightUnit,
                    options: ["CM", "FT"])
                .frame(width: 100)
            }
        }
    }
}

#Preview {
    PersonalInfoView(viewModel: OnboardingViewModel())
}
