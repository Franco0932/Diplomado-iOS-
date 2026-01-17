//
//  PokemonListViewModel.swift
//  Pokedex2
//
//  Created by Franco Ruiz on 17/01/26.
//

import Foundation

class PokemonListViewModel {
    private let pokemonDataFileName = "Pokemon_List"
    private let pokemonDataFileExtension = "json"
    
    public var pokemonCellIdentifier = "pokemon-cell"
    public let title = "Pokedex"
    
    private var pokemonList: [Pokemon] = []
    public var pokemonCount: Int { pokemonList.count }
    
    init () {
        pokemonList = loadPokemonData()
    }
    
    //MARK: - public methods
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        pokemonList[indexPath.row]
    }
    
    //MARK: - private methods
    
    
    func loadPokemonData() -> [Pokemon] {
        guard let fileUrl = Bundle.main.url(forResource: pokemonDataFileName, withExtension: pokemonDataFileExtension),
              let pokemonData = try? Data(contentsOf: fileUrl),
              let pokemonList = try? JSONDecoder().decode([Pokemon].self, from: pokemonData)
        else{
            assertionFailure("Cannot Find File \(pokemonDataFileName).\(pokemonDataFileExtension)") //Siempre es recomendable poner, es una herramienta para programar de forma defensiva, asegurando que tus suposiciones sobre el flujo de datos sean correctas durante la fase de desarrollo.
            return[]
        }
        return pokemonList
    }
}
