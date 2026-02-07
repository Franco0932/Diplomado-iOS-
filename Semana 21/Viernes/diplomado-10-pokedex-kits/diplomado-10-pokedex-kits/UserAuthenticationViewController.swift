//
//  UserAuthenticationViewController.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 24/01/26.
//

import UIKit
import LocalAuthentication

class UserAuthenticationViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        isModalInPresentation = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("Programmatic viewcontroller")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
   
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        let containerStack = UIStackView()
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        containerStack.axis = .vertical
        containerStack.spacing = 8
        
        let authLabel = UILabel()
        authLabel.translatesAutoresizingMaskIntoConstraints = false
        authLabel.adjustsFontForContentSizeCategory = true
        authLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        authLabel.numberOfLines = 0
        authLabel.text = "Please authenticate"
        
        var authButtonConfiguration = UIButton.Configuration.filled()
        authButtonConfiguration.title = "authenticate"
        
        let authButton = UIButton(configuration: authButtonConfiguration)
        authButton.translatesAutoresizingMaskIntoConstraints = false
        authButton.addTarget(self,
                             action: #selector(authButtonTapped),
                             for: .touchUpInside)
        
        view.addSubview(containerStack)
        
        containerStack.addArrangedSubview(authLabel)
        containerStack.addArrangedSubview(authButton)
        
        NSLayoutConstraint.activate([
            containerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            containerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
            
        ])
    }
    
    @objc
    private func authButtonTapped() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                     error: &error) {
            let reason = "identify to view pokemon"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        self.dismiss(animated: true)
                    }
                }
                
            }
        }
    }

}
