//
//  GrowingText.swift
//  Fitly
//
//  Created by Govind Sah on 13/07/25.
//

import SwiftUI

struct TypingTextView: View {
    let fullText: String
    let typingSpeed: Double // characters per second
    var completion: (() -> Void)?

    @State private var displayedText = ""
    @State private var currentIndex = 0
    @State private var timer: Timer?

    var body: some View {
        Text(displayedText)
            .font(.system(size: 14, weight: .medium, design: .monospaced))
            .onAppear {
                startTyping()
            }
            .onDisappear {
                timer?.invalidate()
            }
    }

    private func startTyping() {
        displayedText = ""
        currentIndex = 0

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1 / typingSpeed, repeats: true) { _ in
            if currentIndex < fullText.count {
                let index = fullText.index(fullText.startIndex, offsetBy: currentIndex)
                displayedText.append(fullText[index])
                currentIndex += 1
            } else {
                completion?()
                timer?.invalidate()
            }
        }
    }
}

struct GrowingText: View {
    var body: some View {
        TypingTextView(fullText: "Hello, welcome to SwiftUI!", typingSpeed: 15)
            .padding()
    }
}
