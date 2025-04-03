//
//  ImageDownloader.swift
//  News Application
//
//  Created by Luka Gujejiani on 13.03.25.
//

import Combine
import SwiftUI

final class ImageDownloader {
    
    // MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Method
    
    func downloadImage(from url: URL) -> AnyPublisher<Image, Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in
                UIImage(data: data)
            }
            .compactMap { $0 }
            .map { Image(uiImage: $0) }
            .replaceError(with: Image(systemName: "photo.fill"))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
