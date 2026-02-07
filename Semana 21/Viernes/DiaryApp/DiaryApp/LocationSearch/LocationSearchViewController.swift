//
//  LocationSearchViewController.swift
//  DiaryApp
//
//  Created by Franco Ruiz on 30/01/26.
//

import UIKit
import MapKit

protocol LocationSearchDelegate: AnyObject {
    func didSelectLocation(_ location: Location)
}

class LocationSearchViewController: UIViewController {
    
    private let viewModel = LocationSearchViewModel()
    weak var delegate: LocationSearchDelegate?
    
    private lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Buscar dirección..."
        sb.delegate = self
        return sb
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Buscar Ubicación"
        
        // Botón cancelar
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        
        viewModel.delegate = self
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
}

extension LocationSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(query: searchText)
    }
}

extension LocationSearchViewController: LocationSearchViewModelDelegate {
    func didUpdateResults() {
        tableView.reloadData()
    }
}

extension LocationSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let result = viewModel.searchResults[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = result.title
        config.secondaryText = result.subtitle
        cell.contentConfiguration = config
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = viewModel.searchResults[indexPath.row]
        
        viewModel.getCoordinate(for: selectedResult) { [weak self] location in
            guard let self = self, let location = location else { return }
            
            self.delegate?.didSelectLocation(location)
            self.dismiss(animated: true)
        }
    }
}
