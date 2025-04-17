//
//  HomeView.swift
//  News Application
//
//  Created by Luka Gujejiani on 12.03.25.
//

import SwiftUI

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State private var selectedCategory: NewsQuery.Category = .general
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerView
                    .background(Color(.systemBackground))
                
                List {
                    Section {
                        Poster(state: homeViewModel.posterState)
                            .frame(maxWidth: .infinity)
                            .listRowInsets(EdgeInsets())
                    }
                    
                    Section {
                        ForEach(homeViewModel.newsCellStates.indices, id: \.self) { idx in
                            NewsCell(state: homeViewModel.newsCellStates[idx])
                                .listRowSeparator(.hidden)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .onAppear {
                homeViewModel.fetchArticles()
            }
            .onChange(of: selectedCategory) {
                homeViewModel.fetchArticles(with: NewsQuery(category: selectedCategory.rawValue))
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("") // you can set a title if you want
        }
    }
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Top Story")
                .font(.largeTitle)
                .bold()
            
            CategoryMenuView(
                categories: NewsQuery.Category.allCases,
                selectedCategory: $selectedCategory
            )
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

//
//import SwiftUI
//
//struct HomeView: View {
//    @EnvironmentObject var homeViewModel: HomeViewModel
//    @State private var selectedCategory: NewsQuery.Category = .general
//
//    var body: some View {
//        NavigationStack {
//            ScrollView(showsIndicators: false) {
//                LazyVStack(alignment: .leading,
//                           pinnedViews: [.sectionHeaders]) {
//
//                    Section(header: headerView) {
//                        Poster(state: homeViewModel.posterState)
//                            .frame(maxWidth: .infinity)
//
//                        Divider()
//                            .padding(.vertical, 8)
//
//                        ForEach(homeViewModel.newsCellStates.indices, id: \.self) { idx in
//                            NewsCell(state: homeViewModel.newsCellStates[idx])
//                        }
//                    }
//                }
//            }
//            .onAppear {
//                homeViewModel.fetchArticles()
//            }
//            .onChange(of: selectedCategory) {
//                homeViewModel.fetchArticles(with: NewsQuery(category: selectedCategory.rawValue))
//            }
//        }
//    }
//
//    /// We extract the header into its own computed property for clarity.
//    private var headerView: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            Text("Top Story")
//                .font(.largeTitle)
//                .bold()
//
//            CategoryMenuView(
//                categories: NewsQuery.Category.allCases,
//                selectedCategory: $selectedCategory
//            )
//        }
//        .padding(.horizontal)
//        .padding(.top, 8)
//        .background(Color(.systemBackground))
//        .frame(maxWidth: .infinity, alignment: .leading)
//    }
//}
