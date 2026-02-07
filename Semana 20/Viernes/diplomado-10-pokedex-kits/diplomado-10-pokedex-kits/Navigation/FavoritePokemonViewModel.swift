//
//  FavoritePokemonViewModel.swift
//  diplomado-10-pokedex-kits Original
//
//  Created by Franco Ruiz on 24/01/26.
//

import Foundation

class FavoritePokemonTableViewModel {
    private let favoritePokemonDataFileName = "favorite_pokemon_list"
    private let favoritePokemonFileExtension = "json"
    private var favoritePokemonList = [Pokemon]()
    
    let title = "Favorites"
    
    var numberOfSections: Int {1}
    var numberOfFlows: Int { favoritePokemonList.count }
}
