//
//  Network.swift
//  News Application
//
//  Created by Luka Gujejiani on 12.03.25.
//

import Foundation
import Combine

protocol NetworkService {
    func getArticles() -> AnyPublisher<[Article], NetworkError>
}

final class Network: NetworkService {
    private let session: URLSession
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    private let apiKey = "04bda797a49346e4aca004ee3402281b"
    private let responseValidator: ResponseValidating
    
    // MARK: - Init
    
    init(session: URLSession = .shared, responseValidator: ResponseValidating = Network.createDefaultValidator()) {
        self.session = session
        self.responseValidator = responseValidator
    }
    
    // MARK: - API Methods
    
    func getArticles() -> AnyPublisher<[Article], NetworkError> {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        guard let url = urlComponents.url else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .tryMap { [weak self] result in
                guard let self = self else { throw NetworkError.unknown(NSError()) }
                try self.responseValidator.validate(result.response)
                return result.data
            }
            .decode(type: Articles.self, decoder: JSONDecoder())
            .map(\.articles)
            .map { articles in
                articles.filter { article in
                    guard article.author != nil,
                          article.title != nil,
                          article.urlToImage != nil,
                          article.publishedAt != nil,
                          article.content != nil else {
                        return false
                    }
                    return true
                }
            }
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return NetworkError.decodingError(decodingError)
                }
                return NetworkError.unknown(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
