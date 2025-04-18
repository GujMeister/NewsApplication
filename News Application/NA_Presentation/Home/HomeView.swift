//
//  HomeView.swift
//  News Application
//
//  Created by Luka Gujejiani on 12.03.25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    @State private var selectedCategory: NewsQuery.Category = .general

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HeaderView

                List {
                  ForEach(vm.articles) { article in
                    NewsCell(article: article)
                      .listRowSeparator(.hidden)
                      .onAppear {
                        vm.loadMoreIfNeeded(currentItem: article)
                      }
                  }
                }
                .listStyle(.plain)
            }
            .onAppear {
                vm.fetchArticles(category: selectedCategory, page: 1)
            }
            .onChange(of: selectedCategory) { newCat in
                vm.fetchArticles(category: newCat, page: 1)
            }
        }
    }

    private var HeaderView: some View {
        VStack(spacing: 12) {
            Text("Top Story")
                .font(.largeTitle).bold()
            CategoryMenuView(
                categories: NewsQuery.Category.allCases,
                selectedCategory: $selectedCategory
            )
        }
        .padding()
        .background(Color(.systemBackground))
    }
}
