//
//  File.swift
//  Ejercicio2Bandas
//
//  Created by Franco Ruiz on 21/11/25.
//

import Foundation

struct Song {
    let name: String
    let duration: String
}

struct Album {
    let title: String
    let releaseYear: String
    let songs: [Song]
}

struct Band {
    let name: String
    let imageName: String
    let albums: [Album]
}
