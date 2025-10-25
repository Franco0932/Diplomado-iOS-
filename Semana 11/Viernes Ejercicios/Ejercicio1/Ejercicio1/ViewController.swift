//
//  ViewController.swift
//  Ejercicio1
//
//  Created by Franco Ruiz on 24/10/25.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentageSegmentedControl: UISegmentedControl!
    @IBOutlet weak var calculateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.isEnabled = false
        billAmountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @objc private func textFieldDidChange(_ sender: UITextField) {
        let isTipFieldEmpty = billAmountTextField.text?.isEmpty ?? true
        calculateButton.isEnabled = !isTipFieldEmpty
}

    @IBAction func calculateTip(_ sender: Any) {
        performSegue(withIdentifier: "mostrarResultado", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mostrarResultado" {
            if let destinationVC = segue.destination as? TipTotalViewController {
                let billAmountText = billAmountTextField.text ?? "0"
                let billAmount = Double(billAmountText) ?? 0.0

                let tipPercentages = [0.10, 0.15, 0.20]
                let tipIndex = tipPercentageSegmentedControl.selectedSegmentIndex
                let tipPercentage = tipPercentages[tipIndex]

                let tip = billAmount * tipPercentage
                let total = billAmount + tip

                destinationVC.tipAmount = tip
                destinationVC.totalAmount = total
            }
        }
    }
}
