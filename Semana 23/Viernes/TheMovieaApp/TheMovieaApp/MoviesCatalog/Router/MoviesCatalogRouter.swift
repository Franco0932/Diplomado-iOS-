//
//  MoviesCatalogRouter.swift
//  TheMovieaApp
//
//  Created by Cristian guillermo Romero garcia on 13/02/26.
//

import Foundation
//import UIKit
//
//class MoviesCatalogRouter: MoviesCatalogRouterProtocol {
//    weak var moviesCatalogView: MoviesCatalogViewController?
//    
//    //MARK: VIPER Methods
//    static func getMoviesCtalogModule() -> UIViewController {
//        let View = MoviesCatalogViewController()
//        let presenter = MoviesCatalogPresenter()
//        let interactor = MoviesCatalogInteractor()
//        let router = MoviesCatalogRouter()
//        
//        /// conecting ...
//        View.presenter = presenter
//        presenter.view = View
//        presenter.interactor = interactor
//        presenter.router = router
//        router.moviesCatalogView = View
//        interactor.presenter = presenter
//        return View
//        
//    }
//}


import UIKit

protocol MovieRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

class MovieRouter: MovieRouterProtocol {
    static func createModule() -> UIViewController {
        let view = MoviesCatalogViewController(nibName: "MoviesCatalogViewController", bundle: nil)
        let presenter = MoviePresenter()
        let interactor = MovieInteractor()
        let router = MovieRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
}
