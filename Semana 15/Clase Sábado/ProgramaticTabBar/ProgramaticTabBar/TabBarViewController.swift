//
//  TabBarViewController.swift
//  ProgramaticTabBar
//
//  Created by Franco Ruiz on 22/11/25.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let firstView = FirstViewController()
    let secondView = SecondViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewControllers([firstView, secondView], animated: true)

    }

}
