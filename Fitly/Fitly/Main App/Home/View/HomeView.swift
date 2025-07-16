//
//  HomeView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 15/07/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 0) {
            headerView()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    PopularWorkoutsView()
                    TodayPlanView()
                        .padding(.horizontal)
                }
                .padding(.bottom, 84)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func headerView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Good Morning 🔥")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Pramuditya Uzumaki")
                .font(.title2).bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 48)
        .padding()
    }
}

#Preview {
    HomeView()
}
