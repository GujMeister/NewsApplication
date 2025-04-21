//
//  NewsCellParameters.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.03.25.
//

import SwiftUI

// MARK: - Parameters

extension NewsCell {
    struct Parameters: Equatable {
        let title: String
        let URL: URL
        let image: Image
        
        public init(title: String, URL: URL, image: Image) {
            self.title = title
            self.URL   = URL
            self.image = image
        }
    }
}

// MARK: - Loading State

extension NewsCell {
    enum LoadingState {
        case loading
        case loaded(Image)
        case failed
    }
}
