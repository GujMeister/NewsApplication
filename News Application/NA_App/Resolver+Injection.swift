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
        register { ArticleRemoteDataSourceImpl() as ArticleRemoteDataSource }
        register { ArticleRepository() as FetchArticlesUseCase }
        register { @MainActor in
            HomeViewModel()
        }
    }
}
