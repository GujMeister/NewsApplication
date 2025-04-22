//
//  Article.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.04.25.
//

import Foundation

struct Article: Identifiable {
    var id: String { author } //UUID = UUID()
    let author: String
    let title: String
    let imageURL: URL
    let publishedAt: Date
    let content: String
}
