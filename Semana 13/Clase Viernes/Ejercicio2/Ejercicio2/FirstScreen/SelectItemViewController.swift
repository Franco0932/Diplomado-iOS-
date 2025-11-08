//
//  ViewController.swift
//  Ejercicio2
//
//  Created by Franco Ruiz on 07/11/25.
//

import UIKit

class SelectItemViewController: UIViewController {
    
    let productNames: [String] = [
        "Manzana", "Agua", "Pan", "Zanahoria", "Queso",
        "Coca-Cola", "Huevos", "Plátanos", "Salchichas", "Carne"
    ]
    
    
    let productImages: [String] = [
        "apple.logo",
        "waterbottle.fill",
        "icons8-pan-48",
        "carrot.fill",
        "icons8-queso-48",
        "icons8-cola-48",
        "icons8-huevos-48",
        "icons8-plátano-48",
        "icons8-salchichas-48",
        "icons8-filete-48"
    ]
    
    let checkmarkImage = UIImage(systemName: "checkmark.circle.fill")
    let shoppingCartImage = UIImage(systemName: "cart.fill")
    
    @IBOutlet var productButtons: [UIButton]!
    @IBOutlet weak var goToShoppingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    
    func setupButtons() {
        let sortedButtons = productButtons.sorted { $0.tag < $1.tag }
        
        for (index, button) in sortedButtons.enumerated() {
            guard index < productImages.count else { continue }
            
            button.addTarget(self, action: #selector(productButtonTapped(_:)), for: .touchUpInside)
            
            updateButtonAppearance(button: button, isSelected: false)
            
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
        }
        
        goToShoppingButton.layer.cornerRadius = 10
    }
    
    
    func updateButtonAppearance(button: UIButton, isSelected: Bool) {
        button.isSelected = isSelected
        let tag = button.tag
        
        if isSelected {
            button.backgroundColor = .systemGreen
            button.setImage(checkmarkImage, for: .normal)
            button.tintColor = .white
        } else {
            button.backgroundColor = .systemBlue
            
            let imageName = (tag < productImages.count) ? productImages[tag] : ""
            let productImage = UIImage(systemName: imageName) ?? UIImage(named: imageName) ?? shoppingCartImage
            
            button.setImage(productImage, for: .normal)
            button.tintColor = .white
        }
    }
    
    
    @objc func productButtonTapped(_ sender: UIButton) {
        let newSelectedState = !sender.isSelected
        
        updateButtonAppearance(button: sender, isSelected: newSelectedState)
    }
    
    @IBAction func goToShoppingButtonTapped(_ sender: Any) {
        var selectedProductNames: [String] = []
        for button in productButtons.sorted(by: { $0.tag < $1.tag }) {
            if button.isSelected {
                let index = button.tag
                if index < productNames.count {
                    selectedProductNames.append(productNames[index])
                }
            }
        }
        let shoppingListVC = ShoppingViewController(nibName: "ShoppingView", bundle: nil)
        shoppingListVC.selectedItems = selectedProductNames
        self.present(shoppingListVC, animated: true)
    }
}

