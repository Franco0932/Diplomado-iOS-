//
//  ResultsViewController.swift
//  Ejercicio3
//
//  Created by Franco Ruiz on 24/10/25.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var foodResultLabel: UISegmentedControl!
    @IBOutlet weak var sportResultLabel: UISwitch!
    @IBOutlet weak var activityResultLabel: UILabel!
    
    var selFood: String?
    var likesFutball: Bool?
    var activity: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let food = selFood {
            var selectedIndex = UISegmentedControl.noSegment
            for i in 0..<foodResultLabel.numberOfSegments {
                if foodResultLabel.titleForSegment(at: i) == food {
                    selectedIndex = i
                    break
                }
            }
            foodResultLabel.selectedSegmentIndex = selectedIndex
        }
        
        if let likes = likesFutball {
            sportResultLabel.setOn(likes, animated: false)
        }
        
        if let act = activity, !act.isEmpty {
            activityResultLabel.text = act
        }
        
        foodResultLabel.isEnabled = false
        sportResultLabel.isEnabled = false
        activityResultLabel.isEnabled = false
    }
}
