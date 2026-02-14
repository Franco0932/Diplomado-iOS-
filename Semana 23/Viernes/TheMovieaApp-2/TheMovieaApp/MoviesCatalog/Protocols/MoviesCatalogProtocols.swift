//
//  MoviesCatalogProtocols.swift
//  TheMovieaApp
//
//  Created by Cristian guillermo Romero garcia on 13/02/26.
//

import Foundation

protocol MoviesCatalogViewProtocol: AnyObject {
    //MARK: VIPER properties
    var presenter: MoviesCatalogPresenterProtocol? {get set}
    
    
    //MARK: presenter -> view
}


protocol MoviesCatalogPresenterProtocol: AnyObject {
    //MARK: VIPER properties
    var view: MoviesCatalogViewProtocol? {get set}
    var interactor: MoviesCatalogInteractorInputProtocol? {get set}
    var router: MoviesCatalogRouterProtocol? {get set}
    
}

protocol MoviesCatalogInteractorInputProtocol: AnyObject{
    //MARK: VIPER properties
    var presenter: MoviesCatalogPresenterProtocol? {get set}
}

protocol MoviesCatalogRouterProtocol: AnyObject {
    
}

protocol MoviesCatalogInteractorOutputProtocol: AnyObject {
    
}
