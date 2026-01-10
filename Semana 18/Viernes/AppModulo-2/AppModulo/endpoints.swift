//
//  endpoints.swift
//  AppModulo
//
//  Created by Franco Ruiz on 09/01/26.
//

import Foundation

enum Endpoint {
    case users([URLQueryItem])
    case photos([URLQueryItem])
    
    var path: String {
        switch self {
        case .users: "/Users"
        case .photos: "/photos"
        }
    }
    
    var queryItem: [URLQueryItem] {
        switch self {
        case .users(let array), .photos(let array): return array
        }
    }
}
