//
//  NewsCellParameters.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.03.25.
//

import SwiftUI

extension NewsCell {
    struct Parameters: Hashable {
        let title: String
        let image: Image
        
        public init(
            title: String,
            image: Image
        ) {
            self.title = title
            self.image = image
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(title)
        }
        
        static func == (lhs: Parameters, rhs: Parameters) -> Bool {
            lhs.title == rhs.title
        }
    }
}
