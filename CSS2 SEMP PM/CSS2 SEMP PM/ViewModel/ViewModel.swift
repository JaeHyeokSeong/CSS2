//
//  ViewModel.swift
//  CSS2 SEMP PM
//
//  Created by John Underwood on 30/3/2024.
//

import Foundation

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
}
