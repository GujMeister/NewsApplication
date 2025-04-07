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
    @Published var posterState: Poster.LoadingState = .loading
    @Published var newsCellStates: [NewsCell.LoadingState] = []
    
    init(articleService: ArticleFetching, imageService: ImageFetching) {
        self.articleService = articleService
        self.imageService = imageService
    }
    
    // MARK: - Fetch Articles
    
    func fetchArticles(with query: NewsQuery = NewsQuery(category: NewsQuery.Category.general.rawValue)) {
        articleService.fetchArticles(with: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: handleCompletion, receiveValue: handleArticles)
            .store(in: &cancellables)
    }
    
    private func handleCompletion(_ completion: Subscribers.Completion<NetworkError>) {
        if case .failure(let error) = completion {
            DispatchQueue.main.async {
                print("Article fetch failed: \(error.localizedDescription)")
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
        guard let firstArticle = articles.first else {
            posterState = .error
            return
        }
        
        loadImage(for: firstArticle.urlToImage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                let params = Poster.Parameters(
                    title: firstArticle.title ?? "No title",
                    image: image,
                    date: firstArticle.publishedAt ?? "Unknown date"
                )
                self?.posterState = .loaded(params)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Populate News Cells
    
    private func populateNewsCells() {
        newsCellStates = Array(repeating: .loading, count: 5)
        
        let articlesToShow = articles.dropFirst()
        var newStates = [NewsCell.LoadingState]()
        
        for _ in articlesToShow {
            newStates.append(.loading)
        }
        
        newsCellStates = newStates
        
        articlesToShow.enumerated().forEach { index, article in
            loadImage(for: article.urlToImage)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] image in
                    let params = NewsCell.Parameters(
                        title: article.title ?? "No title",
                        image: image
                    )
                    if (0..<(self?.newsCellStates.count ?? 0)).contains(index) {
                        self?.newsCellStates[index] = .loaded(params)
                    }
                }
                .store(in: &cancellables)
        }
    }
    
    // MARK: - Helper: Load Image
    private func loadImage(for urlString: String?) -> AnyPublisher<Image, Never> {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return Just(Image(systemName: "photo.fill")).eraseToAnyPublisher()
        }
        return imageService.fetchImage(from: url)
    }
}
