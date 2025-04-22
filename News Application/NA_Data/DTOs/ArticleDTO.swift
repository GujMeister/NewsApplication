//
//  ArticleDTO.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.04.25.
//

import Foundation

struct ArticleDTO: Decodable {
    let articles: [Article]
    
    struct Article: Decodable {
        let author: String?
        let title: String?
        let urlToImage: String?
        let publishedAt: Date
        let content: String?
    }
}
