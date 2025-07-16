//
//  LabeledTextField.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 13/07/25.
//

import SwiftUI

struct LabeledTextField: View {
    let title: String
    @Binding var value: String
    let suffix: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.body)
                .foregroundColor(.secondary)

            HStack {
                TextField("", text: $value)
                    .textFieldStyle(.plain)
                    .font(.body)

                if let suffix = suffix {
                    Text(suffix)
                        .foregroundColor(.gray)
                        .font(.body)
                }
            }
            .padding(.vertical, 6)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.3))
        }
    }
}

import SwiftUI

struct UnderlineTextField: View {
    var title: String
    var placeholder: String
    var suffix: String?

    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            HStack {
                VStack {
                    TextField(placeholder, text: $text)
                        .keyboardType(keyboardType)
                        .textFieldStyle(.plain)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.6))
                }
                if let suffix = suffix {
                    Text(suffix)
                        .foregroundColor(.primary)
                        .font(.subheadline)
                }
            }
        }
    }
}

#Preview {
    UnderlineTextField(
            title: "Age",
            placeholder: "Enter age",
            suffix: "years",
            text: .constant(""),
            keyboardType: .numberPad
        )
        .padding()
}
