//
//  TipTotalViewController.swift
//  Ejercicio1
//
//  Created by Franco Ruiz on 24/10/25.
//

import UIKit

class TipTotalViewController: UIViewController {

    var tipAmount: Double = 0.0
    var totalAmount: Double = 0.0

    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = String(format: "Propina: $%.2f\nTotal: $%.2f", tipAmount, totalAmount)
    }
}

