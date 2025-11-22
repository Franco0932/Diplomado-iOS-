//
//  AlbumViewController.swift
//  Ejercicio2Tablas
//
//  Created by Franco Ruiz on 21/11/25.
//

import UIKit

class AlbumViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedBand: Band?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedBand?.name
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "albumCell")
    }
}

extension AlbumViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedBand?.albums.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumTableViewCell
        
        if let album = selectedBand?.albums[indexPath.row] {
            cell.albumTitleLabel.text = album.title
            cell.albumYearLabel.text = "Año: \(album.releaseYear)"
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedAlbum = selectedBand?.albums[indexPath.row]
        
        let songVC = SongViewController(nibName: "SongViewController", bundle: nil)
        songVC.selectedAlbum = selectedAlbum
        self.navigationController?.pushViewController(songVC, animated: true)
    }
}
