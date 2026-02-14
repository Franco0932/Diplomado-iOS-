//
//  MoviesTableViewCell.swift
//  TheMovieaApp
//
//  Created by Franco Ruiz on 13/02/26.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        if let path = movie.posterPath {
            let urlString = "https://image.tmdb.org\(path)"
            if let url = URL(string: urlString) {
                print("Cargando imagen: \(url)")
            }
        }
    }
}
