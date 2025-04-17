//
//  NewsQuery.swift
//  News Application
//
//  Created by Luka Gujejiani on 07.04.25.
//

import Foundation

struct NewsQuery {
    let country: String?
    let category: String?
    let page: Int?
    
    enum Category: String {
        case general
        case business
        case entertainment
        case health
        case science
        case sports
        case technology
    }
    
    init(country: String? = "us",
         category: String? = nil,
         page: Int? = nil
    ) {
        self.country = country
        self.category = category
        self.page = page
    }
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        
        if let country = country {
            items.append(URLQueryItem(name: "country", value: country))
        }
        
        if let category = category {
            items.append(URLQueryItem(name: "category", value: category))
        }
        
        if let page = page {
            items.append(.init(name: "page", value: String(page)))
        }
        
        return items
    }
}
