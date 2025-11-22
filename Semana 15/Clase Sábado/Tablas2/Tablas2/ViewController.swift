//
//  ViewController.swift
//  Tablas2
//
//  Created by Franco Ruiz on 22/11/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var nombres: [String] = ["Manuel", "Grecia", "Alejandro", "Franco", "Vanesa"]
    var filterArray = [String]()
    let refresh = UIRefreshControl()
    var searching = false
    var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        refresh.addTarget(self, action: #selector(UpdateView), for: .valueChanged)
        tableView.refreshControl = refresh
        
        //Buscador
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    @objc func UpdateView() {
        tableView.reloadData()
        refresh.endRefreshing()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            filterArray.count
        }else{
            nombres.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        if searching {
            cell.textLabel?.text = filterArray[indexPath.row]
        }else{
            cell.textLabel?.text = nombres[indexPath.row]
        }
        return cell
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filtertext = searchController.searchBar.text, !filtertext.isEmpty else{
            filterArray.removeAll()
            searching = false
            tableView.reloadData()
            return
        }
        
        searching = true
        filterArray = nombres.filter{$0.lowercased().contains(filtertext.lowercased())}
        tableView.reloadData()
    }
}
