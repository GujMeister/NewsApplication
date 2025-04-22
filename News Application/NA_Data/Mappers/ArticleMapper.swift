//
//  ArticleMapper.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.04.25.
//

import Foundation

struct ArticleMapper {
    func toDomain(_ dto: ArticleDTO.Article) -> Article? {
        guard
            let author      = dto.author,
            let title       = dto.title,
            let imageURLStr = dto.urlToImage,
            let dateStr     = dto.publishedAt,
            let content     = dto.content
        else { return nil }
        
        guard let imageURL = URL(string: imageURLStr) else { return nil }
        
        guard let publishedDate = ISO8601DateFormatter().date(from: dateStr) else { return nil }
        
        return Article(
            author:      author,
            title:       title,
            imageURL:    imageURL,
            publishedAt: publishedDate,
            content:     content
        )
    }
}
