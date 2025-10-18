//
//  LoginViewController.swift
//  AppModulo
//
//  Created by Franco Ruiz on 11/10/25.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton){
        print("User", userField.text)
        print("password", passwordField.text)
        logIn()
    }
    
    private func logIn(){
        performSegue(withIdentifier: "LoginHomeSegue", sender: nil)
    }
    
}

