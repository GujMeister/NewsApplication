//
//  HomeView.swift
//  News Application
//
//  Created by Luka Gujejiani on 12.03.25.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: Properties
    
    @StateObject private var vm = HomeViewModel()
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HeaderView
                
                List {
                    ForEach(vm.articles) { article in
                        NavigationLink {
                            DetailsView(vm: DetailsViewModel(article: article))
                        } label: {
                            NewsCell(parameters: .init(title: article.title, image: article.imageURL))
                                .listRowSeparator(.hidden)
                                .onAppear {
                                    vm.loadMoreIfNeeded(currentItemID: article.id)
                                }
                        }
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    vm.refresh(category: vm.selectedCategory)
                }
            }
            .onAppear {
                vm.fetchArticles(category: vm.selectedCategory, page: 1)
            }
            .onChange(of: vm.selectedCategory) {
                vm.fetchArticles(category: vm.selectedCategory, page: 1)
            }
        }
        .environmentObject(vm)
    }
}

// MARK: - Extension

extension HomeView {
    private var HeaderView: some View {
        let titles = NewsQuery.Category.allCasesString
        let selectedTitle = Binding<String>(
            get: { vm.selectedCategory.rawValue },
            set: { newRaw in
                if let cat = NewsQuery.Category(rawValue: newRaw) {
                    vm.selectedCategory = cat
                }
            }
        )

        return VStack(spacing: 12) {
            Text("Top Story")
                .font(.largeTitle).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)

            CategoryMenuView(
                categories: titles,
                selectedCategory: selectedTitle
            )
        }
        .background(Color(.systemBackground))
    }
}
