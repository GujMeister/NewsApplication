//
//  Response.swift
//  News Application
//
//  Created by Luka Gujejiani on 12.03.25.
//

import Foundation

// MARK: - Response
struct Response: Decodable {
    let articles: [Article]
    
    struct Article: Decodable {
        let author: String?
        let title: String?
        let urlToImage: String?
        let publishedAt: String?
        let content: String?
    }
}
