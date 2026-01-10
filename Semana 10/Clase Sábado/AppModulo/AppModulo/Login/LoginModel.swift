//
//  LoginModel.swift
//  AppModulo
//
//  Created by Franco Ruiz on 29/11/25.
//

import Foundation

struct LoginModel {
    let repository: UserRepositoryProtocol
    
    func findUser(by email: String, handler: @escaping(Error?) -> Void) {
        do {
            guard let _ = try repository.getUsers(by: email)?.first else {
                handler(LoginModelError.UserNotFound)
                return
            }
            handler(nil)
        }catch{
            handler(error)
        }
    }
    
    enum LoginModelError: Error, LocalizedError {
        case UserNotFound
        
        var errorDescription: String? {
            switch self {
            case .UserNotFound: "User not found, check your email and password"
            }
        }
    }
}
