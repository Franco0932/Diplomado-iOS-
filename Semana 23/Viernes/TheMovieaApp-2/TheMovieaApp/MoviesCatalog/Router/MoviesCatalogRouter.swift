//
//  MoviesCatalogRouter.swift
//  TheMovieaApp
//
//  Created by Cristian guillermo Romero garcia on 13/02/26.
//

import Foundation
import UIKit

class MoviesCatalogRouter: MoviesCatalogRouterProtocol {
    weak var moviesCatalogView: MoviesCatalogViewController?
    
    //MARK: VIPER Methods
    static func getMoviesCtalogModule() -> UIViewController {
        let View = MoviesCatalogViewController()
        let presenter = MoviesCatalogPresenter()
        let interactor = MoviesCatalogInteractor()
        let router = MoviesCatalogRouter()
        
        /// conecting ...
        View.presenter = presenter
        presenter.view = View
        presenter.interactor = interactor
        presenter.router = router
        router.moviesCatalogView = View
        interactor.presenter = presenter
        return View
        
    }
}
