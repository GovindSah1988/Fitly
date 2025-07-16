//
//  RootView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 14/07/25.
//

import SwiftUI

struct RootView: View {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    @AppStorage("isLoggedIn") var isLoggedIn = false

    var body: some View {
        Group {
//            if !isLoggedIn {
//                GetStartedView()
//                    .transition(.scale.combined(with: .opacity))
//            } else if !hasCompletedOnboarding {
//                OnboardingContainerView()
//                    .transition(.scale.combined(with: .opacity))
//            } else {
            MainTabView()
                    .transition(.opacity)
//            }
        }
        .animation(.easeInOut(duration: 0.4), value: isLoggedIn || hasCompletedOnboarding)
    }
}


#Preview {
    RootView()
}
