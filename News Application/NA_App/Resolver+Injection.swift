//
//  Resolver+Injection.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.04.25.
//

import Resolver
import Combine

extension Resolver: @retroactive ResolverRegistering {
    public static func registerAllServices() {
        register { ResponseValidator() as ResponseValidating }
        register { Network()           as NetworkService    }
        register { ArticleRemoteDataSourceImpl() }
            .implements(ArticleRemoteDataSource.self)
        register { ArticleRepository() }
            .implements(FetchArticlesUseCase.self)
        register { @MainActor in
            HomeViewModel()
        }
        register { ImageService() as ImageFetching }
        register { ImageDownloader() }
            .scope(.shared)
    }
}
