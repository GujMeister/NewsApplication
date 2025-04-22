//
//  FetchArticlesUseImpl.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.04.25.
//

import Combine
import Resolver

struct FetchArticlesUseImpl: FetchArticlesUseCase {
    
    @Injected
    private var articleRepository: ArticleRepositoryProtocol
    
    func execute(category: String, page: Int) -> AnyPublisher<[Article], NetworkError> {
        articleRepository.getTopHeadlines(category: category, page: page)
    }
}
