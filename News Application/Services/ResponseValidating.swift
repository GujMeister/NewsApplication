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
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }

        let code = http.statusCode
        guard acceptableStatusCodes.contains(code) else {
            throw NetworkError.badStatusCode(code)
        }
    }
}
