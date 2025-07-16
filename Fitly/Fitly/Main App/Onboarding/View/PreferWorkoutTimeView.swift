//
//  PreferWorkoutTimeView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 14/07/25.
//

import SwiftUI

struct PreferWorkoutTimeView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    @State private var hour = 0
    @State private var minute = 0
    @State private var isAM = true
    @State private var remindersEnabled = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Title
            Text("What time would you like to workout?")
                .font(.title3)
                .fontWeight(.semibold)
            
            // Picker Container
            HStack(spacing: .zero) {
                // Hour Picker
                VStack(spacing: .zero) {
                    Text("Hour")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Picker("", selection: $hour) {
                        ForEach(1...12, id: \.self) { Text(String(format: "%02d", $0)) }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 80, height: 60)
                    .clipped()
                }
                
                Text(":")
                    .font(.title2)
                    .padding(.top, 8)
                
                // Minute Picker
                VStack(spacing: 4) {
                    Text("Minute")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Picker("", selection: $minute) {
                        ForEach(0..<60) { Text(String(format: "%02d", $0)) }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 80, height: 60)
                    .clipped()
                }
                
                // AM/PM toggle
                VStack(spacing: .zero) {
                    Picker("", selection: $isAM) {
                        Text("AM").tag(true)
                        Text("PM").tag(false)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 80)
                }
                .padding(.top, 16)
            }
            .frame(height: 120)
            .padding(.top, 24)
            
            Toggle(isOn: $remindersEnabled) {
                Text("Receive reminders and notifications for workout")
                    .font(.body)
            }
            .toggleStyle(SwitchToggleStyle(tint: .blue))
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    PreferWorkoutTimeView(viewModel: OnboardingViewModel())
}
