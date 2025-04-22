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
    
    let categories: [String]
    @Binding var selectedCategory: String
    
    // MARK: Body
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(categories, id: \.self) { category in
                    CategoryCell(
                        title: category,
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
