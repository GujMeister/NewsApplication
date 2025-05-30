//
//  DefaultArticleRepository.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.04.25.
//

import Combine
import Resolver

struct ArticleRepository: ArticleRepositoryProtocol {
    
    @Injected
    private var dataSource: ArticleDataSource
    private let mapper = ArticleMapper()
    
    func getTopHeadlines(category: String, page: Int) -> AnyPublisher<[Article], NetworkError> {
        return dataSource.getTopHeadlines(category: category, page: page)
            .compactMap { $0.compactMap(self.mapper.toDomain) }
            .eraseToAnyPublisher()
    }
}
