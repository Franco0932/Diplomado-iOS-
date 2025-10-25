//
//  ViewController.swift
//  Ejercicio3
//
//  Created by Franco Ruiz on 24/10/25.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var foodSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sportSwitch: UISwitch!
    @IBOutlet weak var activityField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitSegment()
        foodSegmentedControl.addTarget(self, action: #selector(validateInputs), for: .valueChanged)
        activityField.addTarget(self, action: #selector(validateInputs), for: .editingChanged)
    }

    
    private func InitSegment() {
        sendButton.isEnabled = false
        foodSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
    }
    
    @objc private func validateInputs() {
        let isFoodSelected = foodSegmentedControl.selectedSegmentIndex != UISegmentedControl.noSegment
        
        let isActivityFill = !(activityField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        
        sendButton.isEnabled = isFoodSelected && isActivityFill
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mostrarResultado" {
            if let destinationVC = segue.destination as? ResultsViewController {
                
                let selFoodIn = foodSegmentedControl.selectedSegmentIndex
                let foodChoice = foodSegmentedControl.titleForSegment(at: selFoodIn)
                let likesFutball = sportSwitch.isOn
                let OcioActivity = activityField.text
                
                destinationVC.selFood = foodChoice
                destinationVC.likesFutball = likesFutball
                destinationVC.activity = OcioActivity
            }
        }
    }
    
    @IBAction func sendButtonTaped(_ sender: UIButton) {
        performSegue(withIdentifier: "mostrarResultado", sender: self)
    }
}
