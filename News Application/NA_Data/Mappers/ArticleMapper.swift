//
//  ArticleMapper.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.04.25.
//

import Foundation

struct ArticleMapper {
    private let isoFormatter: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        return f
    }()
    
    func toDomain(_ dto: ArticleDTO.Article) -> Article {
        let imageURL = URL(string: dto.urlToImage ?? "" ) ?? URL(string: "about:blank")!
        
        let publishedDate = isoFormatter.date(from: dto.publishedAt!) ?? Date()
        
        return Article(
            author:      dto.author ?? "NO AUTHOR",
            title:       dto.title ?? "NO TITLE",
            imageURL:    imageURL,
            publishedAt: publishedDate,
            content:     dto.content ?? "NO CONTENT"
        )
    }
}
