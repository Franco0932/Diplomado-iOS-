//
//  Store.swift
//  DonBigotes
//
//  Created by Franco Ruiz on 23/01/26.
//

import Foundation

struct StoreData: Codable {
    let store: Store
}

struct Store: Codable {
    let name: String
    let slogan: String
    let description: String
    let logoURL: String
    let branches: [Branch]
    
    enum CodingKeys: String, CodingKey {
        case name, slogan, description, branches
        case logoURL = "logo_url"
    }
}
