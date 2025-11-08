//
//  ShoppingViewController.swift
//  Ejercicio2
//
//  Created by Franco Ruiz on 07/11/25.
//

import UIKit

class ShoppingViewController: UIViewController {

    var selectedItems: [String] = []

    @IBOutlet weak var itemsLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tu Lista de Compras"
        
        displaySelectedItems()
    }
    
    
    func displaySelectedItems() {
        if selectedItems.isEmpty {
            itemsLabel.text = "No seleccionaste ningún artículo."
        } else {
            let listText = selectedItems.joined(separator: ", ")
            itemsLabel.text = listText
        }
    }
}
