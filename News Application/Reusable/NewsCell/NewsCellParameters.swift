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
        
        public init(
            title: String,
            URL: URL
        ) {
            self.title = title
            self.URL = URL
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
