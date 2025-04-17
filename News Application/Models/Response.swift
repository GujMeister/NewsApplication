//
//  Response.swift
//  News Application
//
//  Created by Luka Gujejiani on 12.03.25.
//

import Foundation

// MARK: - Response
struct Response: Decodable {
    let status: String?
    let totalResults: Double?
    let articles: [Article]
}

// MARK: - Article
struct Article: Decodable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Decodable {
    let id: String?
    let name: String?
}
