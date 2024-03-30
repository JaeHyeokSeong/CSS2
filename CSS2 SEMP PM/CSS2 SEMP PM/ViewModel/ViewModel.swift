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
    
    init() {
        loadMasterPassword()
    }
    
    func loadMasterPassword() {
        let masterKeys: [Login] = load("masterkey.json")
        if let firstMasterKey = masterKeys.first {
            login.masterPassword = firstMasterKey.masterPassword
        }
    }
    
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
    
    func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else{
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do{
            data = try Data(contentsOf: file)
        } catch{
            fatalError("Couldn't load \(filename) from main bundle: \n\(error)")
        }
        do{
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
