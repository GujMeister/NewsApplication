//
//  DefaultArticleRepository.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.04.25.
//

import Combine
import Resolver

class ArticleRepository: FetchArticlesUseCase {
    
    @Injected private var remote: ArticleRemoteDataSource
    private let mapper = ArticleMapper()
    
    func execute(category: String, page: Int) -> AnyPublisher<[Article], NetworkError> {
        print("DefaultArticleRepository - execute")
        return remote.getTopHeadlines(category: category, page: page)
            .map { $0.map(self.mapper.toDomain) }
            .eraseToAnyPublisher()
    }
}
