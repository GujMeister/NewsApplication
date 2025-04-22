//
//  LocalArticleDataSource.swift
//  News Application
//
//  Created by Luka Gujejiani on 22.04.25.
//

import Combine
import Foundation

final class LocalArticleDataSource: ArticleDataSource {
    func getTopHeadlines(category: String, page: Int) -> AnyPublisher<[ArticleDTO.Article], NetworkError> {
        Just(
            [
                .init(
                    author: "author 1",
                    title: "title 1",
                    urlToImage: "",
                    publishedAt: Date(),
                    content: "lorem ipusm dolor sit amet consectetur adipiscing elit ut aliquam purus sit amet luctus"
                )
            ]
        )
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}
