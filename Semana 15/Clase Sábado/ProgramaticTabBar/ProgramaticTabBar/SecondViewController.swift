//
//  SecondViewController.swift
//  ProgramaticTabBar
//
//  Created by Franco Ruiz on 22/11/25.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        self.title = "Second"
        self.tabBarItem.image = UIImage(systemName: "swift")
        self.tabBarItem.selectedImage = UIImage(systemName: "swift")


    }
    

}
