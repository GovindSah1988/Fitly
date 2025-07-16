//
//  LoginView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 12/07/25.
//

import SwiftUI

struct GetStartedView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some View {
        VStack {
            // App Logo
            Text("Fitly")
                .foregroundColor(.blue)
                .padding(.top, 60)
            
            Spacer()
            
            // Title
            Text("Get Started now")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.primary)
                .padding(.bottom, 8)
            
            // Subtitle
            Text("Create an account or log in to explore\nabout our app")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.bottom, 32)
            
            // Sign In Buttons
            HStack(spacing: 20) {
                SignInButton(iconName: "google-logo", systemImage: false) {
                    isLoggedIn = true
                }
                SignInButton(iconName: "apple.logo", systemImage: true) {
                    withAnimation {
                        isLoggedIn = false
                    }
                }
            }
            .padding(.bottom, 60)
            Spacer()
        }
        .padding(.horizontal, 24)
        .background(Color(.systemBackground).ignoresSafeArea())
    }
}

struct SignInButton: View {
    let iconName: String
    let systemImage: Bool
    var onButtonTap: () -> Void
    
    var body: some View {
        Button(action: {
            onButtonTap()
        }) {
            HStack {
                if systemImage {
                    Image(systemName: iconName)
                        .font(.title2)
                        .foregroundColor(.black)
                } else {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
            }
            .frame(width: 80, height: 50)
            .background(Color.white)
            .cornerRadius(14)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
    }
}


#Preview {
    GetStartedView()
}
