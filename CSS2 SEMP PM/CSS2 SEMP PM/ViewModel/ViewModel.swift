//
//  ViewModel.swift
//  CSS2 SEMP PM
//
//  Created by John Underwood on 30/3/2024.
//

import Foundation
import LocalAuthentication

class ViewModel: ObservableObject {
    @Published var login = Login(masterPassword: "")
    
    func matchPasswords(password: String, confirmPassword: String) -> Bool {
        if password == "" || confirmPassword == "" {
            return false
        }
        else if password == confirmPassword {
            login.masterPassword = password
            return true
        }
        return false
    }
    
    func authUser(password: String) -> Bool {
        // Implement database connection
        
        // testing purposes
        if password == login.masterPassword {
            //showLoginScreen = true
            return true
        }
        else {
            return false
            //errorInput = 3
        }
    }

    func faceIDAuth(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Login with Face ID") { success, authenticationError in
                if success {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        } else {
            completion(false) // Biometrics not available or configured
        }
    }
}
