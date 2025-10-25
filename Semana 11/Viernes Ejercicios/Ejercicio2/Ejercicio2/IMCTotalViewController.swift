//
//  IMCTotalViewController.swift
//  Ejercicio2
//
//  Created by Franco Ruiz on 24/10/25.
//

import UIKit

class IMCTotalViewController: UIViewController {

    var totalIMC: Double = 0.0
    var category: String?


    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = String(format: "IMC: %.2f\n%@", totalIMC, category ?? "No disponible")
    }
}
