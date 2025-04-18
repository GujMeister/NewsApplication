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
    
    // TODO: Add changing categories
    @Published var articles: [Article] = []
    @Injected private var fetchUseCase: FetchArticlesUseCase
    private var cancellables = Set<AnyCancellable>()
    
    func fetchArticles(
        category: NewsQuery.Category = .general,
        page: Int = 1
    ) {
        print("HomeViewModel - fetchArticles")
        fetchUseCase.execute(
            category: category.rawValue,
            page: page
        )
        .sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak self] in
                self?.articles.append(contentsOf: $0)
            }
        )
        .store(in: &cancellables)
    }
}
