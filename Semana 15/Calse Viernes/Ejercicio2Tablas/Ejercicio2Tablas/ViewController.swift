//
//  ViewController.swift
//  Ejercicio2Tablas
//
//  Created by Franco Ruiz on 21/11/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var bands: [Band] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bandas"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "BandTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        setupData()
    }
    
    func setupData() {
        let song1 = Song(name: "My Propeller", duration: "3:27")
        let song2 = Song(name: "Crying Lightning", duration: "3:43")
        let song3 = Song(name: "Dangerous Animals", duration: "3:30")
        let song4 = Song(name: "Desesperado", duration: "3:39")
        let song5 = Song(name: "Volcán", duration: "4:48")
        let song6 = Song(name: "Buenos Días Amor", duration: "3:45")
        let song7 = Song(name: "Hardwired", duration: "3:09")
        let song8 = Song(name: "Atlas, Rise!", duration: "6:29")
        let song9 = Song(name: "Halo on Fire", duration: "8:15")
        let album1 = Album(title: "Humbung", releaseYear: "2009", songs: [song1, song2, song3])
        let album2 = Album(title: "El Príncipe de la Canción", releaseYear: "1980", songs: [song4, song5, song6])
        let album3 = Album(title: "Hardwired...To Self-Destruct", releaseYear: "2016", songs: [song7, song8, song9])
        let joseJose = Band(name: "Arctic Monkeys", imageName: "ACAlbum_jpeg", albums: [album1])
        let metallica = Band(name: "José José", imageName: "JJAlbum_jpeg", albums: [album2])
        let arcticMonkeys = Band(name: "Metallica", imageName: "MAlbum_jpeg", albums: [album3])
        bands = [joseJose, metallica, arcticMonkeys]
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? BandTableViewCell else {
            return UITableViewCell()
        }
        let band = bands[indexPath.row]
        cell.bandName.text = band.name
        if let image = UIImage(named: band.imageName) {
            cell.bandImage.image = image
        } else {
            cell.bandImage.image = UIImage(systemName: "music.mic")
        }
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedBand = bands[indexPath.row]
        let albumVC = AlbumViewController(nibName: "AlbumViewController", bundle: nil)
        albumVC.selectedBand = selectedBand
        self.navigationController?.pushViewController(albumVC, animated: true)
    }
}
