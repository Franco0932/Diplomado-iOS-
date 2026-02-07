//
//  Branch.swift
//  DonBigotes
//
//  Created by Franco Ruiz on 23/01/26.
//

import Foundation

struct Branch: Codable {
    
    struct Location: Codable {
        let latitude: Double
        let longitude: Double
    }
    
    let id: Int
    let name: String
    let address: String
    let phone: String
    let openingHours: OpeningHours
    let location: Location
    let services: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, address, phone, location, services
        case openingHours = "opening_hours"
    }
}
