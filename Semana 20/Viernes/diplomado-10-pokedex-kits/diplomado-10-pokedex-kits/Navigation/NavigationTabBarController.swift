//
//  NavigationTabBarController.swift
//  diplomado-10-pokedex-kits Original
//
//  Created by Franco Ruiz on 24/01/26.
//

import UIKit
class NavigationTabBarController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Programatic init(coder:)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
        
    }
    
    private func setUpViewController() {
        let pokemonListViewController = PokemonListTableViewController(style: .insetGrouped)
        let navigationViewController = 
    }
    
}
