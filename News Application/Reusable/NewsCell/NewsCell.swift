//
//  NewsCell.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.03.25.
//

import SwiftUI
import Combine
import Resolver

struct NewsCell: View {
    private let article: Article
    @State private var image: Image = Image(systemName: "photo.fill")
    @Injected private var imageService: ImageFetching
    
    public init(article: Article) {
        self.article = article
    }
    
    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(25)
                .padding()
            
            Text(article.title)
                .font(.headline)
                .padding(.horizontal)
        }
        .onReceive(
            imageService
                .fetchImage(from: article.imageURL)
                .receive(on: DispatchQueue.main)
        ) { fetchedImage in
            self.image = fetchedImage
        }
        .padding(.vertical, 8)
    }
}
