//
//  PokemonDetailViewModel.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 17/01/26.
//


import UIKit

protocol PokemonDetailViewModelDelegate: AnyObject {
    func updatePokemonImage(to image: UIImage)
    func navigateToPokemonDetail(with pokemon: Pokemon)
    func showPokemonNotAvailableAlert()
}

class PokemonDetailViewModel {
    let pokemon: Pokemon
    
    weak var delegate: PokemonDetailViewModelDelegate?
    
    var pokemonName: String { pokemon.name }
    var pokemonNumber: String { pokemon.number }
    
    //Debilidades
    var weaknessesText: String {
        return "Weaknesses: " + pokemon.weaknesses.joined(separator: ", ")
    }
    
    //Evoluciones
    var prevEvolutions: [Evolution] { pokemon.prevEvolution ?? [] }
    var nextEvolutions: [Evolution] { pokemon.nextEvolution ?? [] }
    
    private var allPokemon: [Pokemon] = []
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.loadAllPokemon()
        
        if let imageURL = URL(string: pokemon.imageURL) {
            loadPokemonImage(from: imageURL)
        }
    }
    
    private func loadPokemonImage(from imageURL: URL) {
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: imageURL),
               let pokemonImage = UIImage(data: imageData) {
                
                DispatchQueue.main.async {
                    self?.delegate?.updatePokemonImage(to: pokemonImage)
                }
                
            }
        }
    }
    
    private func loadAllPokemon() {
            guard let fileURL = Bundle.main.url(forResource: "pokemon_list", withExtension: "json"),
                  let data = try? Data(contentsOf: fileURL),
                  let list = try? JSONDecoder().decode([Pokemon].self, from: data) else {
                return
            }
            self.allPokemon = list
        }
        
        func didSelectEvolution(_ evolution: Evolution) {
            if let foundPokemon = allPokemon.first(where: { $0.number == evolution.num }) {
                delegate?.navigateToPokemonDetail(with: foundPokemon)
            } else {
                delegate?.showPokemonNotAvailableAlert()
            }
        }
    }
