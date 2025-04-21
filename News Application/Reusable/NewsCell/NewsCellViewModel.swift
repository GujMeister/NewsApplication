//
//  NewsCellViewModel.swift
//  News Application
//
//  Created by Luka Gujejiani on 20.04.25.
//

import SwiftUI
import Combine
import Resolver

final class NewsCellViewModel: ObservableObject, Identifiable {
    
    // MARK: Properties
    
    let id: UUID
    @Published private(set) var state: LoadingState = .loading

    // MARK: Private
    
    private let article: Article
    private let imageService: ImageFetching
    private var cancellable: AnyCancellable?

    // MARK: Init
    
    init(article: Article,
         imageService: ImageFetching = Resolver.resolve()) {
      self.article = article
      self.id = article.id
      self.imageService = imageService
      loadImage()
    }

    var title: String { article.title }

    // MARK: Methods
    
    func loadImage() {
      state = .loading

      cancellable = imageService
        .fetchImage(from: article.imageURL)
        .tryMap { img in
          if img == Image(systemName: "exclamationmark.triangle.fill") {
            throw URLError(.resourceUnavailable)
          }
          return img
        }
        .map(LoadingState.loaded)
        .catch { _ in Just(.failed) }
        .receive(on: DispatchQueue.main)
        .sink { [weak self] newState in
          self?.state = newState
        }
    }
}


// MARK: - Extension

extension NewsCellViewModel {
    enum LoadingState {
        case loading
        case loaded(Image)
        case failed
    }
}
