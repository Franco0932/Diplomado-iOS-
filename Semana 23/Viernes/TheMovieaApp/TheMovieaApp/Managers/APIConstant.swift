//
//  APIConstant.swift
//  TheMovieaApp
//
//  Created by Franco Ruiz on 13/02/26.
//

import Foundation

struct APIConstant {
    static let baseURL = "https://api.themoviedb.org/3"
    static let apiKey = "d959bb093cd1786c7109386dd79d490d"
    static let imageBaseURL = "https://image.tmdb.org"

    
    static func popularMoviesURL(page: Int = 1) -> URL? {
        let path = "/movie/popular"
        let urlString = "\(baseURL)\(path)?api_key=\(apiKey)&language=us-US&page=\(page)"
        return URL(string: urlString)
    }
}

