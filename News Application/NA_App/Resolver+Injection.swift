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
        register { ImageService() as ImageFetching }
        register { ArticleDataSourceImpl() as ArticleDataSource }
        register { ArticleRepository() as ArticleRepositoryProtocol }
        register { FetchArticlesUseImpl() as FetchArticlesUseCase }
        register { @MainActor in
            HomeViewModel()
        }
    }
}

//register { FetchArticlesUseImpl() as FetchArticlesUseCase }
//register { ArticleRepository() as ArticleRepositoryProtocol }
