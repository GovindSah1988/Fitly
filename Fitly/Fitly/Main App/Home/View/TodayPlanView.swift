//
//  TodayPlanView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 16/07/25.
//

import SwiftUI

struct TodayPlanView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Today Plan")
                .font(.headline)

            VStack(spacing: 16) {
                PlanRow(title: "Push Up", subtitle: "100 Push up a day", progress: 0.45, image: "pushup", level: "Intermediate")
                PlanRow(title: "Sit Up", subtitle: "20 Sit up a day", progress: 0.75, image: "pushup", level: "Beginner")
                PlanRow(title: "Knee Push Up", subtitle: "", progress: 0.25, image: "pushup", level: "Beginner")
                PlanRow(title: "Push Up", subtitle: "100 Push up a day", progress: 1, image: "pushup", level: "Intermediate")
                PlanRow(title: "Sit Up", subtitle: "20 Sit up a day", progress: 0.75, image: "pushup", level: "Beginner")
                PlanRow(title: "Knee Push Up", subtitle: "", progress: 0.0, image: "pushup", level: "Beginner")
            }
        }
    }
}

struct PlanRow: View {
    let title: String
    let subtitle: String
    let progress: CGFloat
    let image: String
    let level: String

    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(spacing: 16) {
                // Image
                Image("pushup") // Replace with your image name
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .clipped()
                
                // Text and Progress
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    // Progress bar
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)))
                                .frame(height: 20)
                            
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(#colorLiteral(red: 0.7333333333, green: 0.9490196078, blue: 0.2745098039, alpha: 1)))
                                .frame(width: geometry.size.width * progress, height: 20)
                            
                            Text(String(format: "%.0f%%", progress * 100))
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .frame(alignment: .leading)
                                .padding(.leading, 12)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            
            // Badge
            Text("Intermediate")
                .font(.caption)
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color.black)
                .clipShape(RoundedCorner(radius: 10, corners: [.bottomLeft, .bottomRight]))
                .clipShape(RoundedCorner(radius: 12, corners: [.bottomLeft, .bottomRight]))
                .offset(x: -16, y: 0)
        }
        .background(Color(.systemGray6))
    }
}

#Preview {
    TodayPlanView()
}
