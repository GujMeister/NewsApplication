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
                    ForEach(vm.cellViewModels) { cellVM in
                        NewsCell(vm: cellVM)
                            .listRowSeparator(.hidden)
                            .onAppear {
                                vm.loadMoreIfNeeded(currentItemID: cellVM.id)
                            }
                    }
                }
                .listStyle(.plain)
            }
            .onAppear {
                vm.fetchArticles(category: vm.selectedCategory, page: 1)
            }
            .onChange(of: vm.selectedCategory) { newCat in
                vm.fetchArticles(category: newCat, page: 1)
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
