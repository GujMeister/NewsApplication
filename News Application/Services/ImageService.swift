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

final class ImageService: ImageFetching {
    @Injected private var responseValidator: ResponseValidating

    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        return URLSession(configuration: config)
    }()

    func fetchImage(from url: URL) -> AnyPublisher<Image, Never> {
        let urlString = url.absoluteString
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let safeURL = URL(string: encodedString) else {
//            return Fail(error: NetworkError.badResponse)
//                .eraseToAnyPublisher()
            return Just(Image(systemName: "exclamationmark.triangle.fill"))
                .eraseToAnyPublisher()
        }

        return session
            .dataTaskPublisher(for: safeURL)
            .timeout(.seconds(5), scheduler: DispatchQueue.global(), customError: { URLError(.timedOut) })
            .retry(1)
            .tryMap { data, response in
                try self.responseValidator.validate(response)
                guard let ui = UIImage(data: data) else {
                    throw URLError(.cannotDecodeContentData)
                }
                return Image(uiImage: ui)
            }
            .replaceError(with: Image(systemName: "exclamationmark.triangle.fill"))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
