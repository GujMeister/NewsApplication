//
//  ImageService.swift
//  News Application
//
//  Created by Luka Gujejiani on 02.04.25.
//

import Combine
import SwiftUI
import Resolver

protocol ImageFetching {
    func fetchImage(from url: URL) -> AnyPublisher<Image, Never>
}

// MARK: - Image Service
final class ImageService: ImageFetching {
    @Injected private var downloader: ImageDownloader
    
    func fetchImage(from url: URL) -> AnyPublisher<Image, Never> {
        return downloader
            .downloadImage(from: url)
            .replaceError(with: Image(systemName: "photo.fill"))
            .eraseToAnyPublisher()
    }
}
