//
//  News_ApplicationApp.swift
//  News Application
//
//  Created by Luka Gujejiani on 12.03.25.
//

import SwiftUI
import Resolver

@main
struct NewsApplicationApp: App {
    
    init() {
        Resolver.register { Network() as NetworkService }
        Resolver.register { ResponseValidator() as ResponseValidating }
        Resolver.register { ImageDownloader() }
        Resolver.register { ImageService(downloader: Resolver.resolve()) as ImageFetching }
        Resolver.register { ArticleService(network: Resolver.resolve()) as ArticleFetching }
        Resolver.register { HomeViewModel(articleService: Resolver.resolve(), imageService: Resolver.resolve()) }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(Resolver.resolve(HomeViewModel.self))
        }
    }
}
