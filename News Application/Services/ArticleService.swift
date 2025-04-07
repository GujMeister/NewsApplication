//
//  ArticleService.swift
//  News Application
//
//  Created by Luka Gujejiani on 02.04.25.
//

import Combine

// MARK: - Protocols
protocol ArticleFetching {
    func fetchArticles(with query: NewsQuery) -> AnyPublisher<[Article], NetworkError>
}

// MARK: - Article Service
final class ArticleService: ArticleFetching {
    private let network: NetworkService

    init(network: NetworkService) {
        self.network = network
    }

    func fetchArticles(with query: NewsQuery) -> AnyPublisher<[Article], NetworkError> {
        return network.getArticles(query: query)
    }
}
