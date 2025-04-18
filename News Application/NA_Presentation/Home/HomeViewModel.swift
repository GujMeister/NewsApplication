//
//  HomeViewModel.swift
//  News Application
//
//  Created by Luka Gujejiani on 12.03.25.
//

import Combine
import Resolver

@MainActor
class HomeViewModel: ObservableObject {
    
    @Injected private var fetchUseCase: FetchArticlesUseCase
    private var cancellables = Set<AnyCancellable>()
    
    @Published var articles: [Article] = []
    @Published var pagination: Int = 1
    @Published var selectedCategory: NewsQuery.Category = .general
    
    func fetchArticles(
        category: NewsQuery.Category,
        page: Int = 1
    ) {
        print("HomeViewModel - fetchArticles(category: \(category), page: \(page))")
        
        if page == 1 {
            articles = []
            selectedCategory = category
        }
        pagination = page
        
        fetchUseCase
            .execute(category: category.rawValue, page: page)
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("Error fetching:", error)
                    }
                },
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
    
    func loadMoreIfNeeded(currentItem: Article) {
        guard let last = articles.last, last.id == currentItem.id else { return }
        fetchArticles(category: selectedCategory, page: pagination + 1)
    }
}
