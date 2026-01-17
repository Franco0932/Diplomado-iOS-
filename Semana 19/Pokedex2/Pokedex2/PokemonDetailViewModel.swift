//
//  PokemonDetailViewModel.swift
//  Pokedex2
//
//  Created by Franco Ruiz on 17/01/26.
//

import UIKit

protocol PokemonDetailViewModelDelegate: AnyObject {
    func updatePokemonImage(to image: UIImage)
}

class PokemonDetailViewModel {
    private let pokemon: Pokemon
    weak var delegate: PokemonDetailViewModelDelegate?
    var pokemonName: String {pokemon.name}
    var pokemonNumber: String {pokemon.number}
    init (pokemon: Pokemon) {
        self.pokemon = pokemon
        
        if let imageUrl = URL(string: pokemon.imageUrl){
            loadPokemonImage(from: imageUrl)
        }
    }
    private func loadPokemonImage(from imageUrl: URL) {
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: imageUrl),
                let pokemonImage = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self?.delegate?.updatePokemonImage(to: pokemonImage)
                }
            }
        }
    }
}
