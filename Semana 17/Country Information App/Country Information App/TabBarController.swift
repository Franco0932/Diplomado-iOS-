//
//  TabBarController.swift
//  Country Information App
//
//  Created by Franco Ruiz on 05/12/25.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let countriesVC = CountriesViewController()
        let countriesNav = UINavigationController(rootViewController: countriesVC)
        countriesNav.tabBarItem = UITabBarItem(title: "Países", image: UIImage(systemName: "flag.fill"), tag: 0)
        let currencyVC = CurrencyViewController()
        let currencyNav = UINavigationController(rootViewController: currencyVC)
        currencyNav.tabBarItem = UITabBarItem(title: "Cambio de Moneda", image: UIImage(systemName: "dollarsign.circle.fill"), tag: 1)
        viewControllers = [countriesNav, currencyNav]
    }
    
    func jumpToCurrency(targetCurrency: String) {
        selectedIndex = 1 
        if let nav = viewControllers?[1] as? UINavigationController,
           let vc = nav.viewControllers.first as? CurrencyViewController {
            vc.setTargetCurrency(targetCurrency)
        }
    }
}
