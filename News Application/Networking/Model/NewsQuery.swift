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
        case general = "General"
        case business = "Business"
        case entertainment = "Entertainment"
        case health = "Health"
        case science = "Science"
        case sports = "Sports"
        case technology = "Technology"
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

// MARK: NewsQuery Extension (Used only for preview) (Is it cool to do it like that?)

extension NewsQuery.Category: CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    static var allCases: [NewsQuery.Category] {
        return [.general, .business, .entertainment, .health, .science, .sports, .technology]
    }
    
    static var allCasesString: [String] {
        allCases.map { $0.rawValue }
    }
}
