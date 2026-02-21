//
//  Favorites.swift
//  Modulo7
//
//  Created by Franco Ruiz on 21/02/26.
//

import SwiftUI

class Favorites: ObservableObject {
    @Published var favoritesIDs: Set<Int> = []
    private let defaultKey = "savedFavorites"
    
    init() {
        if let saved = UserDefaults.standard.array(forKey: defaultKey) as? [Int] {
            favoritesIDs = Set(saved)
        }
    }
    
    func toggleFavorites(id: Int) {
        if favoritesIDs.contains(id) {
            favoritesIDs.remove(id)
        } else {
            favoritesIDs.insert(id)
        }
        save()
    }
    
    func isFavorite(id: Int) -> Bool {
        return favoritesIDs.contains(id)
    }
    
    private func save() {
        UserDefaults.standard.set(Array(favoritesIDs), forKey: defaultKey)
    }
}
