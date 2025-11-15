//
//  HistorialViewController.swift
//  ProyectoModulo2
//
//  Created by Franco Ruiz on 14/11/25.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTextView: UITextView!
    
    var historyEntries: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let textView = historyTextView {
            textView.text = historyEntries.joined(separator: "\n-------------------\n")
        }
    }
}
