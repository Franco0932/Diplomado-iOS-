//
//  Models.swift
//  Ejercicio2Tablas
//
//  Created by Franco Ruiz on 21/11/25.
//

import Foundation

struct Band {
    let name: String
    let imageName: String
    let albums: [Album]
}

struct Album {
    let title: String
    let releaseYear: String
    let songs: [Song]
}

struct Song {
    let name: String
    let duration: String
}
