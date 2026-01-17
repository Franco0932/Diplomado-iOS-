//
//  Pokemon.swift
//  Pokedex2
//
//  Created by Franco Ruiz on 17/01/26.
//

import Foundation

struct Pokemon: Codable {
    struct Location {
        let latitude: Double
        let longitude: Double
    }
    let id: Int
    let number: String
    let name: String
    let imageUrl: String
    let type: [String]
    let location: Location
    
    private enum CodingKeys: String, CodingKey {
        case id
        case number = "num"
        case name
        case imageUrl = "img"
        case type
        case location
    }
    
    
    private enum GeoCodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
        case geolocation = "geo"
    }
}
