//
//  FetchArticlesUseCase.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.04.25.
//

import Combine

protocol FetchArticlesUseCase {
    func execute(category: String, page: Int)
    -> AnyPublisher<[Article], NetworkError>
}
