//
//  Follower.swift
//  EjercicioGitHub
//
//  Created by Franco Ruiz on 10/01/26.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}
