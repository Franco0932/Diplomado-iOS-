//
//  ViewController.swift
//  IBOutletExercise
//
//  Created by Franco Ruiz on 17/10/25.
//

import UIKit

class ViewController: UIViewController {
    
    var isButtonOn = false
    var IsBackGroundWhite = true

    @IBOutlet weak var myButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        isButtonOn.toggle()

        if isButtonOn {
            myButton.setTitle("Off", for: .normal)
        } else {
            myButton.setTitle("On", for: .normal)
        }
    }
    
    @IBAction func OnOffButton(_ sender: Any){
        if IsBackGroundWhite{
            view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        }else{
            view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            }
        IsBackGroundWhite.toggle()
    }

}

