//
//  ViewController.swift
//  Pokedex
//
//  Created by Franco Ruiz on 28/11/25.
//

import UIKit

class PokemonListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    let tableView = UITableView()
    let searchBar = UISearchBar()
    
    var displayedPokemon: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokédex"
        view.backgroundColor = .white
        searchBar.delegate = self
        searchBar.placeholder = "Buscar"
        view.addSubview(searchBar)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        loadData()
    }
    
    func loadData() {
        displayedPokemon = DataRepository.shared.allPokemon
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let p = displayedPokemon[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = p.name
        content.secondaryText = "#\(p.id)"
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = displayedPokemon[indexPath.row]
        let detailVC = PokemonDetailVC()
        detailVC.pokemon = selectedPokemon
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            displayedPokemon = DataRepository.shared.allPokemon
        } else {
            displayedPokemon = DataRepository.shared.allPokemon.filter { p in
                return p.name.lowercased().contains(searchText.lowercased()) || String(p.id).contains(searchText)
            }
        }
        tableView.reloadData()
    }
}
