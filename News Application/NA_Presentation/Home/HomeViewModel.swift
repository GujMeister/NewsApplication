//
//  HomeViewModel.swift
//  News Application
//
//  Created by Luka Gujejiani on 12.03.25.
//

import Foundation
import Combine
import Resolver

@MainActor
class HomeViewModel: ObservableObject {
    
    // MARK: Properties
    
    @Injected private var fetchUseCase: FetchArticlesUseCase
    private var cancellables = Set<AnyCancellable>()
    @Published var articles: [Article] = []
    
    @Published var detailsViewModel: DetailsViewModel?
    @Published var pagination: Int = 1
    @Published var selectedCategory: NewsQuery.Category = .general
    
    // MARK: Methods
    
    func fetchArticles(category: NewsQuery.Category, page: Int = 1) {
        checkIfFirstPage(category: category, page: page)
        pagination = page
        
        fetchUseCase
            .execute(category: category.rawValue, page: page)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] newArticles in
                    guard let self = self else { return }
                    
                    if page == 1 {
                        self.articles = newArticles
                    } else {
                        self.articles.append(contentsOf: newArticles)
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    func loadMoreIfNeeded(currentItemID: String) {
        guard let last = articles.last,
              last.id == currentItemID
        else { return }
        fetchArticles(category: selectedCategory,
                      page: pagination + 1)
    }
    
    func checkIfFirstPage(category: NewsQuery.Category, page: Int) {
        if page == 1 {
            articles = []
            selectedCategory = category
        }
    }
    
    func refresh(category: NewsQuery.Category) {
        articles = []
        selectedCategory = category
        
        fetchArticles(category: category)
    }
}
