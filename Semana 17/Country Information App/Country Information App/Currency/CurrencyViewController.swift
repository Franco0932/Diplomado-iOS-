//
//  CurrencyViewController.swift
//  Country Information App
//
//  Created by Franco Ruiz on 05/12/25.
//

import UIKit

class CurrencyViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let amountField = UITextField()
    let pickerSource = UIPickerView()
    let pickerTarget = UIPickerView()
    let arrowImg = UIImageView()
    let resultLabel = UILabel()
    
    var currencies: [String] = []
    var selectedSourceIndex = 0
    var selectedTargetIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Conversión de Moneda"
        currencies = Array(DataManager.shared.conversionRates.keys).sorted()
        amountField.frame = CGRect(x: 40, y: 240, width: view.frame.width - 80, height: 40)
        amountField.borderStyle = .roundedRect
        amountField.placeholder = "Ingrese una cantidad"
        amountField.keyboardType = .decimalPad
        amountField.textAlignment = .center
        view.addSubview(amountField)
        let stack = UIStackView(frame: CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 120))
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        pickerSource.dataSource = self; pickerSource.delegate = self
        pickerTarget.dataSource = self; pickerTarget.delegate = self
        arrowImg.image = UIImage(systemName: "arrow.right")
        arrowImg.contentMode = .scaleAspectFit
        arrowImg.tintColor = .black
        stack.addArrangedSubview(pickerSource)
        stack.addArrangedSubview(arrowImg)
        stack.addArrangedSubview(pickerTarget)
        view.addSubview(stack)
        let btn = UIButton(type: .system)
        btn.setTitle("Convertir", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.frame = CGRect(x: 40, y: 310, width: view.frame.width - 80, height: 50)
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(convert), for: .touchUpInside)
        view.addSubview(btn)
        resultLabel.frame = CGRect(x: 20, y: 410, width: view.frame.width - 40, height: 50)
        resultLabel.textAlignment = .center
        resultLabel.font = .boldSystemFont(ofSize: 24)
        resultLabel.text = "$0.00"
        view.addSubview(resultLabel)
    }
    
    func setTargetCurrency(_ code: String) {
        if let index = currencies.firstIndex(of: code) {
            selectedTargetIndex = index
            pickerTarget.selectRow(index, inComponent: 0, animated: true)
        }
    }
    
    @objc func convert() {
        amountField.resignFirstResponder()
        guard let text = amountField.text, let value = Double(text) else {
            resultLabel.text = "Ingresa una Cantidad"
            return
        }
        
        //Negativos
        if value < 0 {
            resultLabel.text = "No se permiten negativos"
            resultLabel.textColor = .red
            return
        }
        resultLabel.textColor = .label
        
        let sourceCode = currencies[selectedSourceIndex]
        let targetCode = currencies[selectedTargetIndex]
        if let rates = DataManager.shared.conversionRates[sourceCode],
           let rate = rates[targetCode] {
            let total = value * rate
            resultLabel.text = String(format: "%.2f %@", total, targetCode)
        } else if sourceCode == targetCode {
            resultLabel.text = String(format: "%.2f %@", value, targetCode)
        } else {
            resultLabel.text = "No disponible"
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerSource {
            selectedSourceIndex = row
        } else {
            selectedTargetIndex = row
        }
    }
}
