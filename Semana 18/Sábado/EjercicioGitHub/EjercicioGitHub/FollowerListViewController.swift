//
//  FollowerListViewController.swift
//  EjercicioGitHub
//
//  Created by Franco Ruiz on 10/01/26.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!
    var followers: [Follower] = []
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.tintColor = .systemGreen
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView.dataSource = self
    }
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    func getFollowers() {
        apiGitHub.shared.getFollowers(for: username, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let followers):
                self.followers = followers
                if self.followers.isEmpty {
                    DispatchQueue.main.async { self.showEmptyState() }
                }
                DispatchQueue.main.async { self.collectionView.reloadData() }
            
            case .failure(let error):
                self.presentAlert(title: "Error", message: error.rawValue)
            }
        }
    }
    
    @objc func addButtonTapped() {
        apiGitHub.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.addUserToFavorites(user: user)
            
            case .failure(let error):
                self.presentAlert(title: "Error", message: error.rawValue)
            }
        }
    }
    
    func addUserToFavorites(user: Follower) {
        Favorites.updateWith(favorite: user, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.presentAlert(title: "Error", message: error.rawValue)
                return
            }
            
            self.presentAlert(title: "Usuario Guardado", message: "Has guardado al usuario en favoritos")
        }
    }
    
    func presentAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    func showEmptyState() {
        let messageLabel = UILabel(frame: view.bounds)
        messageLabel.text = "No Followers."
        messageLabel.textAlignment = .center
        messageLabel.textColor = .secondaryLabel
        messageLabel.numberOfLines = 0
        messageLabel.font = .systemFont(ofSize: 28, weight: .bold)
        collectionView.backgroundView = messageLabel
    }
}

extension FollowerListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
        cell.set(follower: followers[indexPath.item])
        return cell
    }
}
