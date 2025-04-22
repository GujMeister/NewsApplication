//
//  ArticleDataSourceImpl.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.04.25.
//

import Foundation
import Combine
import Resolver

//final class LocalArticleDataSource: ArticleDataSource {
//    func getTopHeadlines(category: String, page: Int) -> AnyPublisher<[ArticleDTO.Article], NetworkError> {
//        Just(
//            [
//                .init(
//                    author: "author 1",
//                    title: "title 1",
//                    urlImage: "",
//                    publishedAt: .init(),
//                    content: "lorem ipusm dolor sit amet consectetur adipiscing elit ut aliquam purus sit amet luctus"
//                )
//            ]
//        )
//            .setFailureType(to: NetworkError.self)
//            .eraseToAnyPublisher()
//    }
//}

final class RemoteArticleDataSource: ArticleDataSource {
    
    @Injected
    private var network: NetworkService
    
    func getTopHeadlines(category: String, page: Int) -> AnyPublisher<[ArticleDTO.Article], NetworkError> {
        let items: [URLQueryItem] = [
            .init(name: "country", value: "us"),
            .init(name: "category", value: category),
            .init(name: "page", value: "\(page)"),
            .init(name: "apiKey", value: apiKey)
        ]
        
        print("ArticleRemoteDataSourceImpl - getTopHeadlines")
        
        return network
            .executeNetworkCall(
                path: "/v2/top-headlines",
                queryItems: items,
                responseType: ArticleDTO.self
            )
            .map(\.articles)
            .handleEvents(receiveOutput: { articles in
                print("📰 Fetched \(articles.count)")
            })
            .eraseToAnyPublisher()
    }
}
