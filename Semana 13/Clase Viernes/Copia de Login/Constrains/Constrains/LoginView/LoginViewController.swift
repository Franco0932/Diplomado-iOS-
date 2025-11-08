//
//  ViewController.swift
//  Constrains
//
//  Created by Manuel Sánchez on 22/09/23.
//

import UIKit

 class LoginViewController: UIViewController {
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
     
     private let correctUsername = "Diplomado2024"
     private let correctPassword = "Franco_Junio"

     override func viewDidLoad() {
         super.viewDidLoad()
         
         loginButton.isEnabled = false
         userField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
         passwordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
     }
     
     @objc private func textFieldDidChange(_ sender: UITextField) {
         let isUserFieldEmpty = userField.text?.isEmpty ?? true
         let isPasswordFieldEmpty = passwordField.text?.isEmpty ?? true
         
         loginButton.isEnabled = !isUserFieldEmpty && !isPasswordFieldEmpty
     }

     @IBAction func loginButtonTapped(_ sender: UIButton) {
         if userField.text == correctUsername && passwordField.text == correctPassword {
             logIn()
         } else {
             showErrorAlert()
         }
     }
    
    private func logIn() {
        let homeViewController = HomeViewController(nibName: "AccesView", bundle: nil)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .flipHorizontal
        navigationController.navigationBar.prefersLargeTitles = true
        present(navigationController, animated: true)
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Acceso Denegado", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true)
    }

}

