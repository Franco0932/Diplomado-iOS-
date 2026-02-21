//
//  APIConfig.swift
//  Modulo7
//
//  Created by Franco Ruiz on 21/02/26.
//

import Foundation

struct APIConfig: Sendable {
    static let host = "https://api.weatherapi.com/v1"
    
    enum Weather: String {
        case current = "/current.json"
    }
}
