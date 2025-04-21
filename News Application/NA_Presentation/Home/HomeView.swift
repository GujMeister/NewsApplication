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
                    ForEach(vm.cellViewModels) { viewModel in
                        NavigationLink {
                            DetailsView(vm: DetailsViewModel(article: viewModel.article))
                        } label: {
                            NewsCell(vm: viewModel)
                                .listRowSeparator(.hidden)
                                .onAppear {
                                    vm.loadMoreIfNeeded(currentItemID: viewModel.id)
                                }
                        }
                    }
                }
                .listStyle(.plain)
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
    
    // MARK: Header View
    
    private var HeaderView: some View {
        VStack(spacing: 12) {
            Text("Top Story")
                .font(.largeTitle).bold()
            CategoryMenuView(
                categories: NewsQuery.Category.allCases,
                selectedCategory: $vm.selectedCategory
            )
        }
        .padding()
        .background(Color(.systemBackground))
    }
}
