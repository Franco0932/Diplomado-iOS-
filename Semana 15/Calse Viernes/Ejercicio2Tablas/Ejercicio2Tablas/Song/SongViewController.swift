//
//  SongViewController.swift
//  Ejercicio2Tablas
//
//  Created by Franco Ruiz on 21/11/25.
//

import UIKit

class SongViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedAlbum: Album?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedAlbum?.title
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: "songCell")
    }
}

extension SongViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedAlbum?.songs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongTableViewCell
        
        if let song = selectedAlbum?.songs[indexPath.row] {
            cell.songNameLabel.text = song.name
            cell.durationLabel.text = song.duration
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
