//
//  MoviesCatalogInteractor.swift
//  TheMovieaApp
//
//  Created by Cristian guillermo Romero garcia on 13/02/26.
//

import Foundation

protocol MovieInteractorInputProtocol: AnyObject {
    func getPopularMovies()
}

protocol MovieInteractorOutputProtocol: AnyObject {
    func didFetchMovies(_ movies: [Movie])
    func onError()
}

class MovieInteractor: MovieInteractorInputProtocol {
    weak var presenter: MovieInteractorOutputProtocol?
    
    func getPopularMovies() {
        guard let url = APIConstant.popularMoviesURL() else {
            print("URL Inválida")
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error de red: \(error.localizedDescription)")
                return
            }

            guard let data = data else { return }
            
            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                self?.presenter?.didFetchMovies(movieResponse.results)
            } catch {
                print("Error al decodificar: \(error)")
            }
        }.resume()
    }
}
