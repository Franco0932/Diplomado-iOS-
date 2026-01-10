//
//  Favorites.swift
//  Pokedex
//
//  Created by Franco Ruiz on 28/11/25.
//

import UIKit

class FavoritesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    var favPokemon: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favoritos"
        view.backgroundColor = .white
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    
    func loadFavorites() {
        favPokemon = DataRepository.shared.getFavoritePokemons()
        tableView.reloadData()
    }
    
    func setupTable() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: "favCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
        let p = favPokemon[indexPath.row]
        
        cell.textLabel?.text = p.name
        cell.detailTextLabel?.text = "#\(p.id)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = PokemonDetailVC()
        detailVC.pokemon = favPokemon[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemonToDelete = favPokemon[indexPath.row]
            DataRepository.shared.toggleFavorite(id: pokemonToDelete.id)
            favPokemon.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
