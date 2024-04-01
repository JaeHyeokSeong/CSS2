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
    @Published var credentials: [Credentials] = []
    @Published var generatedPassword: String = ""
    @Published var usedLanguages: [String] = []
    
    private var languageRanges: [LanguageRange] {
            LanguageRangeModel.shared.ranges
        }
    
    init() {
        //deleteMasterKeyFile()
        prepareMasterKeyFile()
        loadLogins()
        prepareCredentialsFile()
        updateAllTimer()
        loadCredentials()
    }
    
    func updateAllTimer(){
        for index in 0..<credentials.count{
            credentials[index].daysCount = 30-daysPassed(credentials[index].date)
        }
        saveCredentials()
    }
    func daysPassed(_ date: Date) -> Int{
        let calendar = Calendar.current
        let currentDate = Date()
        
        let components = calendar.dateComponents([.day], from: date, to: currentDate)
        return components.day ?? 0
    }
    
    func generatePassword(totalLength: Int) {
        let totalLength = max(32, min(totalLength, 64))
        var passwordChars: [String] = []
        var usedLangDescriptions: Set<String> = []
        
        for _ in 0..<(totalLength - 4) {
            guard let charRange = languageRanges.randomElement() else { continue }
            let charCode = Int.random(in: charRange.start...charRange.end)
            if let scalar = UnicodeScalar(charCode) {
                let char = String(Character(scalar))
                passwordChars.append(char)
                usedLangDescriptions.insert(charRange.description)
            }
        }
        
        generatedPassword = passwordChars.joined()
        usedLanguages = Array(usedLangDescriptions).sorted()
    }
    
    func filteredCredentials(searchText: String) -> [Credentials] {
        let lowercasedSearchText = searchText.lowercased()
        if searchText.isEmpty {
            return credentials
        } else {
            return credentials.filter { credential in
                if let siteAddress = credential.siteAddress {
                    let emailMatch = credential.email.lowercased().contains(lowercasedSearchText)
                    let passwordMatch = credential.password.lowercased().contains(lowercasedSearchText)
                    let linkMatch = siteAddress.lowercased().contains(lowercasedSearchText)
                    return emailMatch || passwordMatch || linkMatch
                } else {
                    return false
                }
            }
        }
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
            }
        }
    }
    
    private func prepareCredentialsFile() {
        let fileManager = FileManager.default
        let documentsDirectory = getDocumentsDirectory()
        let credentialsFileURL = documentsDirectory.appendingPathComponent("credentials.json")
        
        if !fileManager.fileExists(atPath: credentialsFileURL.path) {
            let emptyCredentials: [Credentials] = []
            if let data = try? JSONEncoder().encode(emptyCredentials) {
                do {
                    try data.write(to: credentialsFileURL, options: .atomic)
                    print("credentials.json was successfully created with initial data.")
                } catch {
                    print("Error creating credentials.json: \(error)")
                }
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
    
    func loadCredentials() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("credentials.json")
        do {
            let data = try Data(contentsOf: fileURL)
            self.credentials = try JSONDecoder().decode([Credentials].self, from: data)
        } catch {
            print("Error loading credentials: \(error)")
        }
    }


    func updateLogin(id: String, newMasterPassword: String) {
        if let index = login.firstIndex(where: { $0.id == id }) {
            login[index].masterPassword = newMasterPassword
            print("Updated login: \(login[index])")
            saveLogins()
        }
    }
    
    func updateCredential(id: String, updatedCredential: Credentials) {
        if let index = credentials.firstIndex(where: { $0.id == id }) {
            credentials[index] = updatedCredential
            
            print("Updated credential: \(credentials[index])")
            saveCredentials()
        } else {
            print("Credential with ID \(id) not found.")
        }
    }
    
    func deleteCredential(id: String) {
        if let index = credentials.firstIndex(where: { $0.id == id }) {
            credentials.remove(at: index)
            print("Deleted credential with ID: \(id)")
            saveCredentials()
        } else {
            print("Credential with ID \(id) not found.")
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
    
    func saveCredentials() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("credentials.json")
        
        do {
            let data = try JSONEncoder().encode(credentials)
            try data.write(to: fileURL, options: .atomic)
            print("Credentials saved successfully.")
        } catch {
            print("Failed to save credentials: \(error)")
        }
    }

    
    func matchPasswords(password: String, confirmPassword: String) -> Bool {
        if password.isEmpty || confirmPassword.isEmpty {
            return false
        } else if password == confirmPassword {
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


