//
//  HomeViewModel.swift
//  News Application
//
//  Created by Luka Gujejiani on 12.03.25.
//

import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let articleService: ArticleFetching
    private let imageService: ImageFetching
    
    private(set) var articles: [Article] = []
    @Published var posterParameters: Poster.Parameters?
    @Published var newsCellParameters: [NewsCell.Parameters] = []
    
    init(articleService: ArticleFetching, imageService: ImageFetching) {
        self.articleService = articleService
        self.imageService = imageService
    }
    
    // MARK: - Fetch Articles
    internal func fetchArticles() {
        articleService.fetchArticles()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: handleCompletion, receiveValue: handleArticles)
            .store(in: &cancellables)
    }
    
    private func handleCompletion(_ completion: Subscribers.Completion<NetworkError>) {
        if case .failure(let error) = completion {
            DispatchQueue.main.async {
                print("Article fetch failed: \(error.localizedDescription)")
                
                #if DEBUG
                debugPrint("Full error details:", error)
                #endif
            }
        }
    }
    
    private func handleArticles(_ articles: [Article]) {
        guard !articles.isEmpty else { return }
        self.articles = articles
        populatePoster()
        populateNewsCells()
    }
    
    // MARK: - Populate Poster
    private func populatePoster() {
        guard let firstArticle = articles.first else { return }
        
        loadImage(for: firstArticle.urlToImage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.posterParameters = Poster.Parameters(
                    title: firstArticle.title ?? "No title",
                    image: image,
                    date: firstArticle.publishedAt ?? "Unknown date"
                )
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Populate News Cells
    private func populateNewsCells() {
        let publishers = articles.dropFirst()
            .compactMap { article -> AnyPublisher<NewsCell.Parameters, Never>? in
                loadImage(for: article.urlToImage)
                    .map { image in NewsCell.Parameters(title: article.title ?? "No title", image: image) }
                    .eraseToAnyPublisher()
            }
        
        guard !publishers.isEmpty else { return }
        
        Publishers.MergeMany(publishers)
            .collect()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] parameters in
                self?.newsCellParameters = parameters
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Helper: Load Image
    private func loadImage(for urlString: String?) -> AnyPublisher<Image, Never> {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return Just(Image(systemName: "photo.fill")).eraseToAnyPublisher()
        }
        return imageService.fetchImage(from: url)
    }
}
