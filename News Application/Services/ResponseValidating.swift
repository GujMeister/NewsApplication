//
//  ResponseValidating.swift
//  News Application
//
//  Created by Luka Gujejiani on 02.04.25.
//

import Foundation

protocol ResponseValidating {
    func validate(_ response: URLResponse) throws
}

final class ResponseValidator: ResponseValidating {
    private let acceptableStatusCodes: Range<Int>
    
    init(acceptableStatusCodes: Range<Int> = 200..<300) {
        self.acceptableStatusCodes = acceptableStatusCodes
    }
    
    func validate(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }
        
        let statusCode = httpResponse.statusCode
        
        if acceptableStatusCodes.contains(statusCode) {
            return
        }
        
        switch statusCode {
        case 400:
            throw NetworkError.badStatusCode(400)
        case 401:
            throw NetworkError.badStatusCode(401)
        case 403:
            throw NetworkError.badStatusCode(403)
        case 404:
            throw NetworkError.badStatusCode(404)
        case 408:
            throw NetworkError.badStatusCode(408)
        case 429:
            throw NetworkError.badStatusCode(429)
        case 500, 502, 503, 504:
            throw NetworkError.badStatusCode(statusCode)
        default:
            throw NetworkError.badStatusCode(statusCode)
        }
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
