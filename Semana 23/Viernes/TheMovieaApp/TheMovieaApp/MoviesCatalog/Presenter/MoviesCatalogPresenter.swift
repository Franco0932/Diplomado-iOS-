//
//  MoviesCatalogPresenter.swift
//  TheMovieaApp
//
//  Created by Cristian guillermo Romero garcia on 13/02/26.
//

import Foundation

//class MoviesCatalogPresenter: MoviesCatalogPresenterProtocol, MoviesCatalogInteractorOutputProtocol {
//    
//    //MARK: VIPER properties
//    var view: (any MoviesCatalogViewProtocol)?
//    var interactor: (any MoviesCatalogInteractorInputProtocol)?
//    var router: (any MoviesCatalogRouterProtocol)?
//    
//    
//}

protocol MovieViewProtocol: AnyObject {
    func reloadTable()
}

protocol MoviePresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfRows() -> Int
    func movie(at index: Int) -> Movie
    func didSelectMovie(_ movie: Movie)
}

class MoviePresenter: MoviePresenterProtocol {
    weak var view: MovieViewProtocol?
    var interactor: MovieInteractorInputProtocol?
    var router: MovieRouterProtocol?
    
    var movies: [Movie] = []
    
    func viewDidLoad() {
        interactor?.getPopularMovies()
    }
    
    func numberOfRows() -> Int {
        return movies.count
    }
    
    func movie(at index: Int) -> Movie {
        return movies[index]
    }

    func didSelectMovie(_ movie: Movie) {
    }
}

extension MoviePresenter: MovieInteractorOutputProtocol {
    func didFetchMovies(_ movies: [Movie]) {
        self.movies = movies
        view?.reloadTable()
    }
    
    func onError() {
    }
}
