//
//  HomeView.swift
//  News Application
//
//  Created by Luka Gujejiani on 12.03.25.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State private var selectedCategory: NewsQuery.Category = .general
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Top Story")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
                CategoryMenuView(
                    categories: NewsQuery.Category.allCases,
                    selectedCategory: $selectedCategory
                )
                
                Poster(state: homeViewModel.posterState)
                    .frame(maxWidth: .infinity)
                
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: geometry.size.width * 0.9, height: 2)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                VStack {
                    ForEach(homeViewModel.newsCellStates.indices, id: \.self) { index in
                        NewsCell(state: homeViewModel.newsCellStates[index])
                    }
                }
            }
        }
        .onAppear {
            homeViewModel.fetchArticles()
        }
        .onChange(of: selectedCategory) { newCategory in
            homeViewModel.fetchArticles(with: NewsQuery(category: selectedCategory.rawValue))
        }
    }
}
