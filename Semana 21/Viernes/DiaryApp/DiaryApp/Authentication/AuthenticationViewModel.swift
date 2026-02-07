//
//  AuthenticationViewModel.swift
//  DiaryApp
//
//  Created by Franco Ruiz on 30/01/26.
//

import Foundation
import LocalAuthentication

protocol AuthenticationViewModelDelegate: AnyObject {
    func authenticationSuccessful()
    func authenticationFailed(error: String)
}

class AuthenticationViewModel {
    
    weak var delegate: AuthenticationViewModelDelegate?
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Desbloquear el diario"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self?.delegate?.authenticationSuccessful()
                    } else {
                        let errorMessage = authenticationError?.localizedDescription ?? "Error desconocido"
                        self?.delegate?.authenticationFailed(error: errorMessage)
                    }
                }
            }
        } else {
            delegate?.authenticationFailed(error: "Biometría no disponible")
        }
    }
}
