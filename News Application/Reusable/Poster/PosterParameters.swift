//
//  PosterParameters.swift
//  News Application
//
//  Created by Luka Gujejiani on 13.03.25.
//

import SwiftUI

extension Poster {
    struct Parameters {
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
