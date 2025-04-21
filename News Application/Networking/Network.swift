//
//  Network.swift
//  News Application
//
//  Created by Luka Gujejiani on 12.03.25.
//

import Foundation
import Combine
import Resolver

let apiKey = "04bda797a49346e4aca004ee3402281b"
let path = "/v2/top-headlines"
let domain = "newsapi.org"

protocol NetworkService {
    func executeNetworkCall<Result: Decodable>(
        path: String,
        queryItems: [URLQueryItem],
        responseType: Result.Type
    ) -> AnyPublisher<Result, NetworkError>
}

final class Network: NetworkService {
    
    @Injected private var responseValidator: ResponseValidating
    
    func executeNetworkCall<Result : Decodable>(
        path: String,
        queryItems: [URLQueryItem] = [],
        responseType: Result.Type
    ) -> AnyPublisher<Result, NetworkError> {
        
        print("Network - executeNetworkCall")
        
        var components = URLComponents()
        components.scheme     = "https"
        components.host       = domain
        components.path       = path.hasPrefix("/") ? path : "/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        print("Making request to: \(request)")
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
}

extension Network {
    static func createDefaultValidator() -> ResponseValidating {
        return ResponseValidator()
    }
    
    static func createValidator(withAcceptableStatusCodes acceptableStatusCodes: Range<Int>) -> ResponseValidating {
        return ResponseValidator(acceptableStatusCodes: acceptableStatusCodes)
    }
}
