//
//  FirstViewController.swift
//  ProgramaticTabBar
//
//  Created by Franco Ruiz on 22/11/25.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        
        self.title = "First"
        self.tabBarItem.image = UIImage(systemName: "swift")
        self.tabBarItem.selectedImage = UIImage(systemName: "swift")
    }
    

    
}
