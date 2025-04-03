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
        let image: Image
        
        public init(
            title: String,
            image: Image
        ) {
            self.title = title
            self.image = image
        }
    }
}

// MARK: - Loading State

extension NewsCell {
    enum LoadingState: Equatable {
        case loading
        case loaded(Parameters)
    }
}
