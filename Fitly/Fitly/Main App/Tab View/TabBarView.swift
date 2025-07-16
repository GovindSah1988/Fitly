////
////  TabBarView.swift
////  Fitly
////
////  Created by Govind Sah on 13/07/25.
////
//
//import SwiftUI
//
//// Define an enum for the different tabs
//enum Tab: String, CaseIterable {
//    case home = "house.fill"
//    case search = "magnifyingglass"
//    case profile = "person.fill"
//    case settings = "gearshape.fill"
//
//    var title: String {
//        switch self {
//        case .home: return "Home"
//        case .search: return "Search"
//        case .profile: return "Profile"
//        case .settings: return "Settings"
//        }
//    }
//}
//
//struct TabBarView: View {
//    @Binding var selectedTab: Tab
//
//    var body: some View {
//        HStack {
//            // Iterate over all cases in the Tab enum to create tab items
//            ForEach(Tab.allCases, id: \.self) { tab in
//                Button(action: {
//                    self.selectedTab = tab // Update the selected tab
//                }) {
//                    VStack(spacing: 4) {
//                        Image(systemName: tab.rawValue) // SF Symbol for the icon
//                            .font(.title2)
//                        Text(tab.title) // Title for the tab
//                            .font(.caption)
//                    }
//                    .foregroundColor(selectedTab == tab ? .blue : .gray) // Highlight selected tab
//                    .padding(.vertical, 8)
//                    .frame(maxWidth: .infinity) // Distribute space equally
//                }
//                //.glassEffect(.regular, in: .capsule)
//            }
//        }
//        .padding(.horizontal, 10) // Horizontal padding for the tab bar
//        //.glassEffect(in: .capsule)
//        .background(
//            RoundedRectangle(cornerRadius: 20, style: .continuous)
//                .fill(Material.ultraThinMaterial)
//                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
//        )
//        .padding(.horizontal) // Padding to keep the tab bar off the screen edges
//    }
//}
//
//// Sample content views for each tab
//struct HomeView: View {
//    var body: some View {
//        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .edgesIgnoringSafeArea(.all)
//            VStack {
//                Image(systemName: "house.fill")
//                    .font(.largeTitle)
//                    .foregroundColor(.blue)
//                Text("Welcome Home!")
//                    .font(.title)
//                    .foregroundColor(.primary)
//            }
//        }
//    }
//}
//
//struct SearchView: View {
//    var body: some View {
//        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .edgesIgnoringSafeArea(.all)
//            VStack {
//                Image(systemName: "magnifyingglass")
//                    .font(.largeTitle)
//                    .foregroundColor(.green)
//                Text("Search for anything...")
//                    .font(.title)
//                    .foregroundColor(.primary)
//            }
//        }
//    }
//}
//
//struct ProfileView: View {
//    var body: some View {
//        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .edgesIgnoringSafeArea(.all)
//            VStack {
//                Image(systemName: "person.fill")
//                    .font(.largeTitle)
//                    .foregroundColor(.purple)
//                Text("Your Profile")
//                    .font(.title)
//                    .foregroundColor(.primary)
//            }
//        }
//    }
//}
//
//struct SettingsView: View {
//    var body: some View {
//        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .edgesIgnoringSafeArea(.all)
//            VStack {
//                Image(systemName: "gearshape.fill")
//                    .font(.largeTitle)
//                    .foregroundColor(.orange)
//                Text("App Settings")
//                    .font(.title)
//                    .foregroundColor(.primary)
//            }
//        }
//    }
//}
//
//// Main App View
//struct MainView: View {
//    @State private var selectedTab: Tab = .home // State to manage the currently selected tab
//
//    @State var dietPrompt = "Find the diet plan for a male of 25 years of age whose body weight is 79.5 kg, skeletal muscle mass is 33.5 kg, and Body Fat Mass is 20.2 kg, body fat percentage is 25.4%, whose BMI is 26.9 and BMR is 1651 calories per day, Visceral Fat Level is 9. target weight is 69.8 kg"
//
//    @State var excercisePrompt = "What physical activities should someone do to stay healthy, and fit and strong for a male of 35 years of age whose body weight is 79.5 kg, skeletal muscle mass is 33.5 kg, and Body Fat Mass is 20.2 kg, body fat percentage is 25.4%, whose BMI is 26.9 and BMR is 1651 calories per day, Visceral Fat Level is 9. target weight is 69.8 kg. "
//
//    @State var workoutPrompt = "Find the workout plan for a male of 35 years of age whose body weight is 79.5 kg, skeletal muscle mass is 33.5 kg, and Body Fat Mass is 20.2 kg, body fat percentage is 25.4%, whose BMI is 26.9 and BMR is 1651 calories per day, Visceral Fat Level is 9. target weight is 69.8 kg. What workout should I do different day a week to help achieve this and yet stay healthy, and fit and strong"
//
//    let languageModelManager: LanguageModelManager // Inject here
//
//    var body: some View {
//        ZStack(alignment: .bottom) { // Align the tab bar to the bottom
//            // Use a Group to conditionally display the selected view
//            Group {
//                switch selectedTab {
//                case .home:
//                    let generateDietPlanUseCase = DefaultGenerateDietPlanUseCase(languageModelManager: languageModelManager)
//                    DietPlanView1(prompt: dietPrompt, generateDietPlanUseCase: generateDietPlanUseCase)
//                        .navigationTitle("DietPlan")
//                case .search:
//                    let generateExcercisePlanUseCase = DefaultGenerateExercisePlanUseCase(languageModelManager: languageModelManager)
//                    ExercisePlanView1(prompt: excercisePrompt, excercisePlanUserCase: generateExcercisePlanUseCase)
//                        .navigationTitle("ExcercisePlan")
//                case .profile:
//                    let generateWorkoutPlanUseCase = DefaultGenerateWorkoutPlanUseCase(languageModelManager: languageModelManager)
//                    WorkoutPlanView(prompt: workoutPrompt, useCase: generateWorkoutPlanUseCase)
//                        .navigationTitle("WorkoutPlan")
//                case .settings:
//                    let generateExcercisePlanUseCase = DefaultGenerateExercisePlanUseCase(languageModelManager: languageModelManager)
//                    ExerciseSuggestionView(prompt: excercisePrompt, excercisePlanUserCase: generateExcercisePlanUseCase)
//                        .navigationTitle("ExcercisePlan")
//                }
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure content fills the screen
//
//            // The custom TabBarView
//            TabBarView(selectedTab: $selectedTab)
//        }
//    }
//}
