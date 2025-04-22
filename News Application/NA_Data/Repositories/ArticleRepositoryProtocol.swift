//
//  ArticleRepositoryProtocol.swift
//  News Application
//
//  Created by Luka Gujejiani on 22.04.25.
//

import Combine

protocol ArticleRepositoryProtocol {
    func getTopHeadlines(category: String, page: Int) -> AnyPublisher<[Article], NetworkError>
}
