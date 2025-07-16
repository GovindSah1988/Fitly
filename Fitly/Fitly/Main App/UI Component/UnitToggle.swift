//
//  UnitToggle.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 13/07/25.
//

import SwiftUI

struct UnitToggle: View {
    @Binding var selectedUnit: String
    let options: [String]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedUnit = option
                }) {
                    Text(option)
                        .font(.subheadline)
                        .foregroundColor(selectedUnit == option ? .white : .gray)
                        .frame(width: 48, height: 32)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(selectedUnit == option ? Color.blue : Color.clear)
                        )
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}


struct CustomSegmentedToggle: View {
    @Binding var selected: String
    let options: [String]
    
    // Colors from your design
    let selectedBackground: Color = .blue
    let selectedText: Color = .white
    let unselectedText: Color = .gray
    let borderColor: Color = .gray.opacity(0.4)

    var body: some View {
        HStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selected = option
                }) {
                    Text(option)
                        .font(.system(size: 14, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 36)
                        .foregroundColor(selected == option ? selectedText : unselectedText)
                        .background(
                            selected == option ? selectedBackground : Color.clear
                        )
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor, lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.ultraThinMaterial) // 👈 Liquid glass background
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


//#Preview {
//    VStack {
//            CustomSegmentedToggle(
//                selected: .constant("FT"),
//                options: ["CM", "FT"]
//            )
//            .padding()
//        }
//}


#Preview {
    UnitToggle(selectedUnit: .constant("KG"), options: ["KG", "LBS"])
}
