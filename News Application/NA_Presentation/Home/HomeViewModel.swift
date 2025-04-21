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
    private var articles: [Article] = []
    
    @Published var cellViewModels: [NewsCellViewModel] = []
    @Published var pagination: Int = 1
    @Published var selectedCategory: NewsQuery.Category = .general
    
    // MARK: Methods
    
    func fetchArticles(category: NewsQuery.Category, page: Int = 1) {
        if page == 1 {
            articles = []
            cellViewModels = []
            selectedCategory = category
        }
        pagination = page
        
        fetchUseCase
            .execute(category: category.rawValue, page: page)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] newArticles in
                    guard let self = self else { return }
                    
                    if page == 1 {
                        self.articles = newArticles
                        self.cellViewModels = newArticles.map {
                            NewsCellViewModel(article: $0)
                        }
                    } else {
                        self.articles.append(contentsOf: newArticles)
                        let newVMs = newArticles.map {
                            NewsCellViewModel(article: $0)
                        }
                        self.cellViewModels.append(contentsOf: newVMs)
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    func loadMoreIfNeeded(currentItemID: UUID) {
        guard let last = cellViewModels.last,
              last.id == currentItemID
        else { return }
        fetchArticles(category: selectedCategory,
                      page: pagination + 1)
    }
    
    func remove(_ id: UUID) {
        if let idx = articles.firstIndex(where: { $0.id == id }) {
            articles.remove(at: idx)
        }
        cellViewModels.removeAll { $0.id == id }
    }
}
