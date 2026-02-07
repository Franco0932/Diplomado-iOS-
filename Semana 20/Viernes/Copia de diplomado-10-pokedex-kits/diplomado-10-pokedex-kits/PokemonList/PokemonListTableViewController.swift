//
//  PokemonListTableViewController.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 17/01/26.
//

import UIKit

class PokemonListTableViewController: UITableViewController {
    let model = PokemonListViewModel()
    
    //Search Controller
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search Pokemon"
        return search
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = model.title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: model.pokemonCellIdentifier)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.pokemonCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: model.pokemonCellIdentifier,
                                                 for: indexPath)

        var cellConfiguration = cell.defaultContentConfiguration()
        let pokemon = model.pokemon(at: indexPath)
        
        cellConfiguration.text = pokemon.name
        cellConfiguration.secondaryText = pokemon.number

        cell.contentConfiguration = cellConfiguration
        
        return cell
    }
}

// MARK: Update de los Results
extension PokemonListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        model.filterPokemon(for: searchBar.text ?? "")
        tableView.reloadData()
    }
}

// MARK: - TableView Delegate
extension PokemonListTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedPokemon = model.pokemon(at: indexPath)
        let detailViewController = PokemonDetailViewController(pokemon: selectedPokemon)
        
        navigationController?.pushViewController(detailViewController,
                                                 animated: true)
    }
}
