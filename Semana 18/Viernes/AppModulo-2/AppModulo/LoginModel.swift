//
//  LoginModel.swift
//  AppModulo
//
//  Created by Yibriam on 29/11/25.
//

import Foundation

struct LoginModel {
    
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
//    func findUser(by email: String, handler: @escaping(Error?) -> Void) {
//        do {
//            guard let _ = try repository.getUsers(by: email)?.first else {
//                handler(LoginModelError.userNotFound)
//                return
//            }
//            handler(nil)
//        } catch {
//            handler(error)
//            
//        }
//    }
    
    func findUser(by email: String, handler: @escaping(Error?) -> Void) {
        repository.getUsers(by: email){ result in
            switch result {
            case.success(let users):
                if users?.isEmpty ?? true {
                    handler(NSError(domain: "LoginModel", code: -100))
                }else{
                    handler(nil)
                }
                handler(nil)
            case.failure(let failure):
                handler(failure)
            }
        }
    }
    
    func findUser(by email: String) async throws {
        let user = try await repository.getUsers(by: email)
        let user?.isEmpty ?? true {
            throw
        }
    }
    
    
    private enum LoginModelError: Error, LocalizedError {
        case userNotFound
        
        var errorDescription: String? {
            switch self {
            case .userNotFound: "User not found, check your email and password."
            }
        }
    }
}
