//
//  ViewController.swift
//  Ejercicio2Bandas
//
//  Created by Franco Ruiz on 21/11/25.
//

import UIKit

class ViewController: UIViewController {

    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var bands: [Band] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bandas"
        view.backgroundColor = .white
        setupTableView()
        setupData()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BandTableViewCell.self, forCellReuseIdentifier: "customCell")
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupData() {
        let song1 = Song(name: "My Propeller", duration: "3:27")
        let song2 = Song(name: "Crying Lightning", duration: "3:43")
        let song3 = Song(name: "Dangerous Animals", duration: "3:30")
        let album1 = Album(title: "Humbung", releaseYear: "2009", songs: [song1, song2, song3])
        
        let song4 = Song(name: "Desesperado", duration: "3:39")
        let song5 = Song(name: "Volcán", duration: "4:48")
        let song6 = Song(name: "Buenos Días Amor", duration: "3:45")
        let album2 = Album(title: "El Príncipe de la Canción", releaseYear: "1980", songs: [song4, song5, song6])
        
        let song7 = Song(name: "Hardwired", duration: "3:09")
        let song8 = Song(name: "Atlas, Rise!", duration: "6:29")
        let song9 = Song(name: "Halo on Fire", duration: "8:15")
        let album3 = Album(title: "Hardwired...To Self-Destruct", releaseYear: "2016", songs: [song7, song8, song9])
        
        let song10 = Song(name: "Do I Wanna Now?", duration: "4:32")
        let song11 = Song(name: "R U Mine?", duration: "3:21")
        let song12 = Song(name: "Arabella", duration: "3:27")
        let album4 = Album(title: "AM", releaseYear: "2013", songs: [song10, song11, song12])
        
        let song13 = Song(name: "The Car", duration: "3:19")
        let song14 = Song(name: "Hello You", duration: "4:05")
        let song15 = Song(name: "Big Ideas", duration: "3:58")
        let album5 = Album(title: "The Car", releaseYear: "2022", songs: [song13, song14, song15])
        
        let song16 = Song(name: "Nothing Else Matters", duration: "6:26")
        let song17 = Song(name: "Enter Sandman", duration: "5:31")
        let song19 = Song(name: "Sad But True", duration: "5:25")
        let album6 = Album(title: "The Black Album", releaseYear: "1991", songs: [song16, song17, song19])
        
        let song20 = Song(name: "Master of Puppets", duration: "8:35")
        let song21 = Song(name: "Battery", duration: "5:12")
        let song22 = Song(name: "Orion", duration: "8:28")
        let album7 = Album(title: "Master of Puppets", releaseYear: "1986", songs: [song20, song21, song22])
        
        let song23 = Song(name: "Lo Dudo", duration: "3:09")
        let song24 = Song(name: "El amor acabe", duration: "6:29")
        let song25 = Song(name: "Lagrimas", duration: "8:15")
        let album8 = Album(title: "Secretos", releaseYear: "1983", songs: [song16, song17, song19])
        
        let song26 = Song(name: "Seré", duration: "3:09")
        let song27 = Song(name: "Payaso", duration: "4:29")
        let song28 = Song(name: "Disimula", duration: "3:15")
        let album9 = Album(title: "Reflexiones", releaseYear: "1984", songs: [song20, song21, song22])
        
        let joseJose = Band(name: "José José", imageName: "JJAlbum", albums: [album2, album8, album9])
        let metallica = Band(name: "Metallica", imageName: "MAlbum", albums: [album3, album6, album7])
        let arcticMonkeys = Band(name: "Arctic Monkeys", imageName: "AMAlbum", albums: [album1, album4, album5])
        
        bands = [arcticMonkeys, joseJose, metallica]
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
        cell.bandNameLabel.text = band.name
        
        if let image = UIImage(named: band.imageName) {
            cell.bandImageView.image = image
        } else {
            cell.bandImageView.image = UIImage(systemName: "music.mic")
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
        let albumVC = AlbumViewController()
        albumVC.selectedBand = selectedBand
        navigationController?.pushViewController(albumVC, animated: true)
    }
}
