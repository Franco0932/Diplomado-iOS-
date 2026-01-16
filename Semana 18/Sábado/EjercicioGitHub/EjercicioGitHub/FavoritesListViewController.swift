//
//  FavoriteListViewController.swift
//  EjercicioGitHub
//
//  Created by Franco Ruiz on 10/01/26.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    let tableView = UITableView()
    var favorites: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favoritos"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FavCell")
    }
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                self.favorites = favorites
                DispatchQueue.main.async { self.tableView.reloadData() }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath)
        let favorite = favorites[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = favorite.login
        content.secondaryText = "Toca para ver seguidores"
        apiGitHub.shared.downloadImage(from: favorite.avatarUrl) { image in
            DispatchQueue.main.async {
                if let updateCell = tableView.cellForRow(at: indexPath) {
                    var newContent = updateCell.defaultContentConfiguration()
                    newContent.text = favorite.login
                    newContent.image = image
                    newContent.imageProperties.maximumSize = CGSize(width: 60, height: 60)
                    newContent.imageProperties.cornerRadius = 30
                    updateCell.contentConfiguration = newContent
                }
            }
        }
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowerListVC()
        destVC.username = favorite.login
        destVC.title = favorite.login
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favoriteToRemove = favorites[indexPath.row]
        PersistenceManager.updateWith(favorite: favoriteToRemove, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard error == nil else { return }
            self.favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
