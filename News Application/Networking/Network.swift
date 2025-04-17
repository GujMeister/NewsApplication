//
//  Network.swift
//  News Application
//
//  Created by Luka Gujejiani on 12.03.25.
//

import Foundation
import Combine

let apiKey = "04bda797a49346e4aca004ee3402281b"
let domain = "newsapi.org"

protocol NetworkService {
    func executeNetworkCall<Result: Decodable>(
        path: String,
        queryItems: [URLQueryItem],
        responseType: Result.Type
    ) -> AnyPublisher<Result, NetworkError>
    func getArticles(query: NewsQuery) -> AnyPublisher<[Article], NetworkError>
}

final class Network: NetworkService {
    
    // MARK: Properties
    private let responseValidator: ResponseValidating
    
    // MARK: Init
    init(responseValidator: ResponseValidating = Network.createDefaultValidator()) {
        self.responseValidator = responseValidator
    }
    
    // MARK: API Methods
    func executeNetworkCall<Result : Decodable>(
        path: String,
        queryItems: [URLQueryItem] = [],
        responseType: Result.Type
    ) -> AnyPublisher<Result, NetworkError> {
        
        var components = URLComponents()
        components.scheme     = "https"
        components.host       = domain
        components.path       = path.hasPrefix("/") ? path : "/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { [validator = responseValidator] data, response in
                try validator.validate(response)
                return data
            }
            .decode(type: Result.self, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                case let decoding as DecodingError :   return .decodingError(decoding)
                case let network as NetworkError   :    return network
                default:
                    return .unknown(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    func getArticles(query: NewsQuery) -> AnyPublisher<[Article], NetworkError> {
        var items = [ URLQueryItem(name: "apiKey", value: apiKey) ]
        
        if let country = query.country {
            items.append(.init(name: "country", value: country))
        }
        
        if let category = query.category {
            items.append(.init(name: "category", value: category))
        }
        
        if let page = query.page {
            items.append(.init(name: "page", value: String(page)))
        }
        
        return executeNetworkCall(
            path: "/v2/top-headlines",
            queryItems: items,
            responseType: Response.self
        )
        .map(\.articles)
        .eraseToAnyPublisher()
    }
}

extension Network {
    static func createDefaultValidator() -> ResponseValidating {
        return ResponseValidator()
    }
    
    static func createValidator(withAcceptableStatusCodes acceptableStatusCodes: Range<Int>) -> ResponseValidating {
        return ResponseValidator(acceptableStatusCodes: acceptableStatusCodes)
    }
}
