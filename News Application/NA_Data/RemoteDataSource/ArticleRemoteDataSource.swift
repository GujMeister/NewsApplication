//
//  ArticleRemoteDataSource.swift
//  News Application
//
//  Created by Luka Gujejiani on 17.04.25.
//

import Combine

protocol ArticleRemoteDataSource {
    func getTopHeadlines(category:String, page:Int)
    -> AnyPublisher<[ArticleDTO.Article],NetworkError>
}
