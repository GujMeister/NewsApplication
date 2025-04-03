//
//  PosterParameters.swift
//  News Application
//
//  Created by Luka Gujejiani on 13.03.25.
//

import SwiftUI

// MARK: - Parameters

extension Poster {
    struct Parameters: Equatable {
        let title: String
        let image: Image
        let date: String
        
        public init(
            title: String,
            image: Image = Image(systemName: "photo.fill"),
            date: String
        ) {
            self.title = title
            self.image = image
            self.date = date
        }
    }
}

// MARK: - Loading State

extension Poster {
    enum LoadingState: Equatable {
        case loading
        case loaded(Parameters)
        case error
    }
}
