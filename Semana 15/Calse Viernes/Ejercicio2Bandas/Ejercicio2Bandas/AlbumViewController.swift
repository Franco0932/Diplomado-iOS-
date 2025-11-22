//
//  AlbumViewController.swift
//  Ejercicio2Bandas
//
//  Created by Franco Ruiz on 21/11/25.
//

import UIKit

class AlbumViewController: UIViewController {

    var selectedBand: Band?
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = selectedBand?.name ?? "Álbumes"
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension AlbumViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedBand?.albums.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "subtitleCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "subtitleCell")
        }
        if let album = selectedBand?.albums[indexPath.row] {
            cell?.textLabel?.text = album.title
            cell?.detailTextLabel?.text = "\(album.releaseYear)"
        }
        
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedAlbum = selectedBand?.albums[indexPath.row] else { return }
        let songVC = SongViewController()
        songVC.selectedAlbum = selectedAlbum
        navigationController?.pushViewController(songVC, animated: true)
    }
}
