//
//  ViewController.swift
//  Ejercicio2
//
//  Created by Franco Ruiz on 24/10/25.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var kgTextField: UITextField!
    @IBOutlet weak var alturaTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        kgTextField.delegate = self
        alturaTextField.delegate = self
        calculateButton.isEnabled = false
        kgTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        alturaTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = ".1234567890"
        let allowedCharactersSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        
        return allowedCharactersSet.isSuperset(of: typedCharacterSet)
    }

    @objc private func textFieldDidChange(_ sender: UITextField) {
        let isKgFieldEmpty = kgTextField.text?.isEmpty ?? true
        let isAlturaFieldEmpty = alturaTextField.text?.isEmpty ?? true
        calculateButton.isEnabled = !isKgFieldEmpty && !isAlturaFieldEmpty
}

    @IBAction func calculateIMC(_ sender: Any) {
        performSegue(withIdentifier: "mostrarResultado", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mostrarResultado" {
            if let destinationVC = segue.destination as? IMCTotalViewController {
                let kgText = kgTextField.text ?? "0"
                let kgPerson = Double(kgText) ?? 0.0
                let alturaText = alturaTextField.text ?? "0"
                let alturaPerson = Double(alturaText) ?? 0.0

                let total = kgPerson / (alturaPerson * alturaPerson)
                
                var category = ""
                
                switch total{
                case ..<18.5:
                    category = "Bajo Peso"
                case 18.5..<24.9:
                    category = "Normal"
                case 25.0..<29.9:
                    category = "Sobrepeso"
                case 30.0..<34.9:
                    category = "Obesidad I"
                case 35.0..<39.9:
                    category = "Obesidad II"
                case 40.0..<49.9:
                    category = "Obesidad III"
                default:
                    category = "Obesidad IV"
                }

                destinationVC.totalIMC = total
                destinationVC.category = category

            }
        }
    }
}

