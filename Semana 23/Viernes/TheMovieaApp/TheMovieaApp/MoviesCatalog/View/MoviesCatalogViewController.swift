//
//  MoviesCatalogViewController.swift
//  TheMovieaApp
//
//  Created by Cristian guillermo Romero garcia on 13/02/26.
//

import UIKit

class MoviesCatalogViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: MoviePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Populares"
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieCell")
        tableView.rowHeight = 150
    }
}

extension MoviesCatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell,
              let movie = presenter?.movie(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.configure(with: movie)
        return cell
    }
}

extension MoviesCatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = presenter?.movie(at: indexPath.row) {
            presenter?.didSelectMovie(movie)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MoviesCatalogViewController: MovieViewProtocol {
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
