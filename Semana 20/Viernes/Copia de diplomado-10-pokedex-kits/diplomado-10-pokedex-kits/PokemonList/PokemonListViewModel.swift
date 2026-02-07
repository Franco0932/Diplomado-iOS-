//
//  PokemonListViewModel.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 17/01/26.
//

import Foundation

class PokemonListViewModel {
    private let pokemonDataFileName = "pokemon_list"
    private let pokemonDataFileExtension = "json"
        
    private var pokemonList: [Pokemon] = []
    
    private var filteredPokemonList: [Pokemon] = []
    
    public var pokemonCellIdentifier = "pokemon-cell"
    public let title = "Pokedex"
    
    private var isSearching = false
    
    public var pokemonCount: Int {
        return isSearching ?
        filteredPokemonList.count :
        pokemonList.count
    }
    
    init() {
        pokemonList = loadPokemonData()
    }
    
    // MARK: - public methods
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        return isSearching ?
        filteredPokemonList[indexPath.row] :
        pokemonList[indexPath.row]
    }
    
    func filterPokemon(for searchText: String) {
            if searchText.isEmpty {
                isSearching = false
                filteredPokemonList.removeAll()
            } else {
                isSearching = true
                filteredPokemonList = pokemonList.filter { pokemon in
                    let nameMatch = pokemon.name.lowercased().contains(searchText.lowercased())
                    let numberMatch = pokemon.number.contains(searchText)
                    return nameMatch || numberMatch
                }
            }
        }
    
    // MARK: - private methods
    func loadPokemonData() -> [Pokemon] {
        guard let fileURL = Bundle.main.url(forResource: pokemonDataFileName,
                                            withExtension: pokemonDataFileExtension),
              let pokemonData = try? Data(contentsOf: fileURL),
              let pokemonList = try? JSONDecoder().decode([Pokemon].self, from: pokemonData)
        else {
            assertionFailure("Cannot find file \(pokemonDataFileName).\(pokemonDataFileExtension)")
            return []
        }
        
        
        return pokemonList
    }
    
}
