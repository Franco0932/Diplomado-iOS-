//
//  MoviesCatalogPresenter.swift
//  TheMovieaApp
//
//  Created by Cristian guillermo Romero garcia on 13/02/26.
//

import Foundation

class MoviesCatalogPresenter: MoviesCatalogPresenterProtocol, MoviesCatalogInteractorOutputProtocol {
    
    //MARK: VIPER properties
    var view: (any MoviesCatalogViewProtocol)?
    var interactor: (any MoviesCatalogInteractorInputProtocol)?
    var router: (any MoviesCatalogRouterProtocol)?
    
    
}
