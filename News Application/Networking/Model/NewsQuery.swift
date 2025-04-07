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
    let language: String?
    
    enum Category: String {
        case general
        case business
        case entertainment
        case health
        case science
        case sports
        case technology
    }
    
    enum Language: String {
        case ar, de, en, es, fr, he, it, nl, no, pt, ru, sv, ud, zh
    }
    
    init(country: String? = "us",
         category: String? = nil,
         language: String? = nil) {
        self.country = country
        self.category = category
        self.language = language
    }
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        
        if let country = country {
            items.append(URLQueryItem(name: "country", value: country))
        }
        
        if let category = category {
            items.append(URLQueryItem(name: "category", value: category))
        }
        
        if let language = language {
            items.append(URLQueryItem(name: "language", value: language))
        }
        
        return items
    }
}
