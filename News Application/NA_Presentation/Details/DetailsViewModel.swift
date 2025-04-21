//
//  DetailsViewModel.swift
//  News Application
//
//  Created by Luka Gujejiani on 21.04.25.
//

import Foundation

@MainActor
class DetailsViewModel: ObservableObject {
    
    // MARK: Properties
    @Published var article: Article
    
    // MARK: Init
    
    init(article: Article) {
        self.article = article
    }
}
