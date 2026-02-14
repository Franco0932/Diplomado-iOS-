//
//  Movie.swift
//  TheMovieaApp
//
//  Created by Franco Ruiz on 13/02/26.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
    }
}
