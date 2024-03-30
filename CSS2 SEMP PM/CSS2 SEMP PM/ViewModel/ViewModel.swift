//
//  ViewModel.swift
//  CSS2 SEMP PM
//
//  Created by John Underwood on 30/3/2024.
//

import Foundation
import LocalAuthentication

class ViewModel: ObservableObject {
    @Published var login: [Login] = []
    
    init() {
//        deleteMasterKeyFile()
        prepareMasterKeyFile()
        loadLogins()
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func deleteMasterKeyFile() {
        let fileManager = FileManager.default
        let documentsDirectory = getDocumentsDirectory()
        let masterKeyFileURL = documentsDirectory.appendingPathComponent("masterkey.json")
        
        do {
            try fileManager.removeItem(at: masterKeyFileURL)
            print("masterkey.json file deleted successfully.")
        } catch {
            print("Error deleting masterkey.json file: \(error)")
        }
    }
    
    
    private func prepareMasterKeyFile() {
        let fileManager = FileManager.default
        let documentsDirectory = getDocumentsDirectory()
        let masterKeyFileURL = documentsDirectory.appendingPathComponent("masterkey.json")
        
        if !fileManager.fileExists(atPath: masterKeyFileURL.path) {
            if let bundleURL = Bundle.main.url(forResource: "masterkey", withExtension: "json") {
                do {
                    try fileManager.copyItem(at: bundleURL, to: masterKeyFileURL)
                } catch {
                    print("Error copying masterkey file from bundle to documents directory: \(error)")
                }
            } else {
                print("masterkey.json is not found in the main bundle.")
                // Optionally create a new masterkey.json file with default values here if needed.
            }
        }
    }
    
    func loadLogins() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("masterkey.json")
        do {
            let data = try Data(contentsOf: fileURL)
            self.login = try JSONDecoder().decode([Login].self, from: data)
        } catch {
            print("Error loading logins: \(error)")
        }
    }

    func updateLogin(id: String, newMasterPassword: String) {
        if let index = login.firstIndex(where: { $0.id == id }) {
            login[index].masterPassword = newMasterPassword
            print("Updated login: \(login[index])")
            saveLogins()
        }
    }
    
    func saveLogins() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("masterkey.json")
        
        do {
            let data = try JSONEncoder().encode(login)
            try data.write(to: fileURL, options: .atomic)
            print("Logins saved successfully.")
        } catch {
            print("Failed to save logins: \(error)")
        }
    }
    
    func matchPasswords(password: String, confirmPassword: String) -> Bool {
        if password.isEmpty || confirmPassword.isEmpty {
            return false
        } else if password == confirmPassword {
            // Assuming the first login is the one to update
            // You may need to adjust this logic based on your app's requirements
            if let firstLoginId = login.first?.id {
                updateLogin(id: firstLoginId, newMasterPassword: password)
            }
            return true
        }
        return false
    }
    
    func authUser(password: String) -> Bool {
        if password == login.first?.masterPassword {
            return true
        } else {
            return false
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
            completion(false)
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
