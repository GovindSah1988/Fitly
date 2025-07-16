//
//  OnboardingContainerView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 13/07/25.
//

import SwiftUI
import SwiftData

struct OnboardingContainerView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @Environment(\.modelContext) private var modelContext
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some View {
        VStack(spacing: .zero) {
            // Top Bar
            HStack() {
                if viewModel.currentStep != .personalInfo {
                    Button(action: {
                        viewModel.back()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .medium))
                    }
                    .frame(height: 24)
                } else {
                    Color.clear
                        .frame(width: 0, height: 24)
                }
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 4)
                        
                        Capsule()
                            .fill(Color.blue)
                            .frame(
                                width: geometry.size.width * CGFloat(viewModel.currentStepIndex) / CGFloat(max(viewModel.steps.count - 1, 1)),
                                height: 4
                            )
                    }
                }
                .frame(height: 4)
            }
            .padding()

            // Step View
            Group {
                switch viewModel.currentStep {
                case .personalInfo:
                    PersonalInfoView(viewModel: viewModel)
                case .fitnessGoal:
                    FitnessGoalSelectionView(viewModel: viewModel)
                case .activityLevel:
                    ActivityLevelSelectionView(viewModel: viewModel)
                case .medicalInfo:
                    MedicalConditionInfoView(viewModel: viewModel)
                case .workoutEnvironment:
                    WorkoutEnvironmentSelectionView(viewModel: viewModel)
                case .typeOfExcersice:
                    TypeOfExercisesSelectionView(viewModel: viewModel)
                case .commitedWorkoutTime:
                    CommitedWorkoutTimeSelectionView(viewModel: viewModel)
                case .preferworkoutDays:
                    WorkoutDaysSelectionView(viewModel: viewModel)
                case .preferworkoutTime:
                    PreferWorkoutTimeView(viewModel: viewModel)
                case .preferDiet:
                    PreferDietSelectionView(viewModel: viewModel)
                }
            }
            .padding()

            Spacer()

            Button(action: {
                if viewModel.isLastStep {
                    saveUserProfile()
                } else {
                    viewModel.next()
                }
            }) {
                Text(viewModel.isLastStep ? "Finish" : "Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isLastStep ? Color.green : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .animation(.easeInOut, value: viewModel.currentStep)
    }
    
    private func saveUserProfile() {
        let profile = UserProfile(
            gender: viewModel.gender,
            age: viewModel.age,
            weight: viewModel.weight,
            height: viewModel.height,
            weightUnit: viewModel.weightUnit,
            heightUnit: viewModel.heightUnit,
            goal: viewModel.selectedGoal
        )
        
        modelContext.insert(profile)
        print("✅ Saved profile to SwiftData: \(profile)")
    }
}


#Preview {
    OnboardingContainerView()
}
