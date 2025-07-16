//
//  SelectableCardView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 13/07/25.
//

import SwiftUI

struct SelectableCardView: View {
    let title: String
    let iconName: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(iconName)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(.top, 12)
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .padding(.bottom, 12)
            }
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.blue : Color.gray.opacity(0.3), lineWidth: 2)
                    .background(isSelected ? Color.blue.opacity(0.1) : Color.clear)
            )
        }
    }
}

#Preview {
    SelectableCardView(title: "Male", iconName: "", isSelected: false, action: { print("Male Selected") })
}
