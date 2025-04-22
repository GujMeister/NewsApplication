//
//  CategoryMenuView.swift
//  News Application
//
//  Created by Luka Gujejiani on 07.04.25.
//

import SwiftUI

// MARK: - Category Menu View

struct CategoryMenuView: View {
    
    // MARK: Properties
    
    let categories: [NewsQuery.Category]
    @Binding var selectedCategory: NewsQuery.Category
    
    // MARK: Body
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(categories, id: \.self) { category in
                    CategoryCell(
                        title: category.rawValue.capitalized,
                        isSelected: selectedCategory == category
                    )
                    .onTapGesture {
                        selectedCategory = category
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 4)
        }
    }
}

// MARK: - Category Cell

struct CategoryCell: View {
    
    // MARK: Properties
    
    let title: String
    let isSelected: Bool
    
    // MARK: Body
    
    var body: some View {
        Text(title)
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(isSelected ? .white : .primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(isSelected ? Color.blue : Color.gray.opacity(0.2))
            )
    }
}

// MARK: - Preview

struct CategoryMenuView_Previews: PreviewProvider {
    @State static var selectedCategory: NewsQuery.Category = .general
    
    static var previews: some View {
        CategoryMenuView(
            categories: NewsQuery.Category.allCases,
            selectedCategory: $selectedCategory
        )
        .previewLayout(.sizeThatFits)
    }
}

// MARK: NewsQuery Extension (Used only for preview) (Is it cool to do it like that?)

extension NewsQuery.Category: CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    static var allCases: [NewsQuery.Category] {
        return [.general, .business, .entertainment, .health, .science, .sports, .technology]
    }
}
