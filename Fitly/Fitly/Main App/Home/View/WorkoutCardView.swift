//
//  WorkoutCardView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 16/07/25.
//

import SwiftUI

struct WorkoutCardView: View {
    let title: String
    let calories: Int
    let duration: Int
    let imageName: String

    var body: some View {
        ZStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300)
                .clipped()
                .cornerRadius(30)

            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(width: 300)
            .cornerRadius(30)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                VStack(alignment: .leading, spacing: 12) {
                    Label("500 Kcal", systemImage: "flame")
                        .font(.subheadline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.ultraThickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    Label("50 Min", systemImage: "clock")
                        .font(.subheadline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.ultraThickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(20)
            .frame(width: 300, alignment: .leading)
        }
        .frame(height: 220)
    }
}

#Preview {
    WorkoutCardView(title: "", calories: 0, duration: 0, imageName: "")
}
