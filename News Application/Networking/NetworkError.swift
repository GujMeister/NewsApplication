//
//  NetworkError.swift
//  News Application
//
//  Created by Luka Gujejiani on 13.03.25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case badResponse
    case badStatusCode(Int)
    case decodingError(DecodingError)
    case unknown(Error)
}
