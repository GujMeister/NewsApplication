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
        let image: URL
        
        public init(title: String, image: URL) {
            self.title = title
            self.image = image
        }
    }
}
