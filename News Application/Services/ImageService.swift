//
//  ImageService.swift
//  News Application
//
//  Created by Luka Gujejiani on 02.04.25.
//

import Combine
import SwiftUI

protocol ImageFetching {
    func fetchImage(from url: URL) -> AnyPublisher<Image, Never>
}


// MARK: - Image Service
final class ImageService: ImageFetching {
    private let downloader: ImageDownloader

    init(downloader: ImageDownloader) {
        self.downloader = downloader
    }

    func fetchImage(from url: URL) -> AnyPublisher<Image, Never> {
        return downloader.downloadImage(from: url)
            .replaceError(with: Image(systemName: "photo.fill"))
            .eraseToAnyPublisher()
    }
}
