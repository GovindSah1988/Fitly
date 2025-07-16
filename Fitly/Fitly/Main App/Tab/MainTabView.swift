//
//  MainTabView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 14/07/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            ScheduleView()
                .tabItem {
                    Image(systemName: "ellipsis.calendar")
                    Text("Schedule")
                }

            Color.red
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Analytics")
                }

            Color.red
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    MainTabView()
}
