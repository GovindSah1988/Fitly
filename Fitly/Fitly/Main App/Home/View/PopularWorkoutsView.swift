//
//  PopularWorkoutsView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 16/07/25.
//

import SwiftUI

struct PopularWorkoutsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Popular Workouts")
                .font(.headline)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    WorkoutCardView(title: "Lower Body Training", calories: 500, duration: 50, imageName: "sample1")
                    WorkoutCardView(title: "Hand Training", calories: 600, duration: 40, imageName: "sample1")
                    WorkoutCardView(title: "Lower Body Training", calories: 500, duration: 50, imageName: "sample1")
                    WorkoutCardView(title: "Hand Training", calories: 600, duration: 40, imageName: "sample1")
                    WorkoutCardView(title: "Lower Body Training", calories: 500, duration: 50, imageName: "sample1")
                    WorkoutCardView(title: "Hand Training", calories: 600, duration: 40, imageName: "sample1")
                    WorkoutCardView(title: "Lower Body Training", calories: 500, duration: 50, imageName: "sample1")
                    WorkoutCardView(title: "Hand Training", calories: 600, duration: 40, imageName: "sample1")
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    PopularWorkoutsView()
}
