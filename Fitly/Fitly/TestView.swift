//
//  TestView.swift
//  Fitly
//
//  Created by Govind Sah on 12/07/25.
//

import FoundationModels
import SwiftUI
import Playgrounds

func checkModelAvailability() async {
    let model = SystemLanguageModel.default
    let availability = await model.availability

    switch availability {
    case .available:
        print("✅ System Language Model is AVAILABLE on this simulator.")
        // Proceed with your LanguageModelSession code
    case .unavailable(let reason):
        print("❌ System Language Model is UNAVAILABLE on this simulator.")
        print("Reason: \(reason)")
        // This 'reason' is key. It will tell you *why* it's unavailable.
        // Common reasons in beta/simulator could be:
        // - .modelNotReady (still downloading or processing)
        // - .deviceNotSupported (less likely on macOS 26 / Xcode 26 simulator, but possible if simulator config is off)
        // - .appleIntelligenceNotEnabled (simulator setting?)
        // - .systemLanguageNotSupported
        // - .storageNotAvailable
        // - .betaNotEnabled (unlikely if you have Xcode 26)
        // - .unknown
    @unknown default:
        print("⚠️ System Language Model availability: Unknown state. Please update Xcode/macOS.")
    }
}

// Call this from your app, e.g., in a View's .onAppear or similar async context
// Example for SwiftUI:
struct ContentView1: View {
    @State private var modelStatus: String = "Checking model availability..."

    var body: some View {
        VStack {
            Text(modelStatus)
            Button("Try Generation") {
                Task {
                    await attemptGeneration()
                }
            }
        }
        .task { // Use .task for async operations in SwiftUI
            await checkAndSetModelStatus()
        }
    }

    private func checkAndSetModelStatus() async {
        let model = SystemLanguageModel.default
        let availability = await model.availability

        switch availability {
        case .available:
            modelStatus = "✅ System Language Model is AVAILABLE."
        case .unavailable(let reason):
            modelStatus = "❌ System Language Model is UNAVAILABLE. Reason: \(reason)"
        @unknown default:
            modelStatus = "⚠️ System Language Model availability: Unknown state."
        }
    }

    private func attemptGeneration() async {
        // Your existing LanguageModelSession code here
        do {
            let session = LanguageModelSession()
            let prompt = "Tell me a short, friendly story about a curious squirrel." // Use a very simple, safe prompt
            let stream = session.streamResponse(to: prompt)
            var fullResponse = ""
            for try await partial in stream {
                fullResponse += partial
            }
            print("Generated response: \(fullResponse)")
        } catch {
            print("Error during generation: \(error)")
            modelStatus = "Error during generation: \(error.localizedDescription)"
        }
    }
}

#Playground {
    let session = LanguageModelSession()
    let response = try await session.respond(to: "Tell the capital of Japan")
    
}
