//
//  GoalSelectionView.swift
//  Fitly
//
//  Created by Jigneshkumar Gangajaliya on 13/07/25.
//

import SwiftUI

struct SelectionItem: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let subTitle: String?
    let icon: String?
    let systemImage: String?
    
    init(
        title: String,
        subTitle: String? = nil,
        icon: String? = nil,
        systemImage: String? = nil
    ) {
        self.title = title
        self.subTitle = subTitle
        self.icon = icon
        self.systemImage = systemImage
    }
}

struct CardSelectionView: View {
    @Binding var selectedItem: String
    let items: [SelectionItem]

    var body: some View {
        VStack(spacing: 16) {
            ForEach(items) { item in
                CardSelectionRowView(
                    item: item,
                    isSelected: item.title == selectedItem,
                    onSelect: {
                        selectedItem = item.title
                    }
                )
            }
        }
        .animation(.easeInOut(duration: 0.25), value: selectedItem)
    }
}

struct CardSelectionRowView: View {
    let item: SelectionItem
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack {
                if let icon = item.icon {
                    Image(icon)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 8)
                } else {
                    EmptyView()
                }
                
                if let systemImage = item.systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: 20))
                        .padding(.trailing, 8)
                } else {
                    EmptyView()
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.body)
                        .foregroundColor(.primary)
                    if let subTitle = item.subTitle {
                        Text(subTitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    } else {
                        EmptyView()                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.blue.opacity(0.2) : Color.clear)
                    .stroke(isSelected ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1.5)
            )
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.3), value: isSelected)
    }
}


#Preview {
    CardSelectionView(selectedItem: .constant(""), items: [SelectionItem(title: "Weight Loss", systemImage: "person.fill.questionmark")])
}
