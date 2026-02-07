//
//  UserAuthenticationViewModel.swift
//  diplomado-10-pokedex-kits
//
//  Created by Franco Ruiz on 30/01/26.
//

import UIKit
import LocalAuthentication

protocol UserAuthenticationViewModelDelegate: AnyObject {
    func authenticationSuccessful()
    func authenticationFailed(error: String)
}

class UserAuthenticationViewModel {
    
    weak var delegate: UserAuthenticationViewModelDelegate?
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify to view pokemon"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self?.delegate?.authenticationSuccessful()
                    } else {
                        let errorMessage = authenticationError?.localizedDescription ?? "Authentication failed"
                        self?.delegate?.authenticationFailed(error: errorMessage)
                    }
                }
            }
        } else {
            delegate?.authenticationFailed(error: "Biometric authentication not available")
        }
    }
}
