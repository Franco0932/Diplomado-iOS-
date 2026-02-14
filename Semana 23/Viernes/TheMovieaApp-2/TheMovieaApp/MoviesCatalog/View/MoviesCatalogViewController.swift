//
//  MoviesCatalogViewController.swift
//  TheMovieaApp
//
//  Created by Cristian guillermo Romero garcia on 13/02/26.
//

import UIKit

class MoviesCatalogViewController: UIViewController, MoviesCatalogViewProtocol {
    
    //MARK: VIPER properties
    var presenter: (any MoviesCatalogPresenterProtocol)?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
