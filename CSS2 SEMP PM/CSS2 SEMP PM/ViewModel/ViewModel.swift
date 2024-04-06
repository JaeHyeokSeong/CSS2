//
//  ViewModel.swift
//  CSS2 SEMP PM
//
//  Created by John Underwood on 30/3/2024.
//

import Foundation
import LocalAuthentication
import CryptoKit

class ViewModel: ObservableObject {
    @Published var login: [Login] = []
    @Published var credentials: [Credentials] = []
    @Published var generatedPassword: String = ""
    @Published var usedLanguages: [String] = []
    private var languageRanges: [LanguageRange] = LanguageRangeModel.shared.ranges
    private var languageOldRanges: [LanguageRange] = LanguageRangeModel.shared.oldRanges
    private var symmetricKeyData: Data?
    
    init() {
//        deleteMasterKeyFile()
        prepareMasterKeyFile()
        loadLogins()
        prepareCredentialsFile()
        loadCredentials()
        updateAllTimer()
        loadOrCreateSymmetricKey()
    }
    
    private func generateAndSaveSymmetricKey() {
        let symmetricKey = SymmetricKey(size: .bits256)
        let keyData = Data(symmetricKey.withUnsafeBytes { Array($0) })
        saveDataToDocumentsDirectory(data: keyData, filename: "symmetricKey.dat")
        self.symmetricKeyData = keyData
    }
        
    private func loadOrCreateSymmetricKey() {
        if let keyData = loadDataFromDocumentsDirectory(filename: "symmetricKey.dat") {
            self.symmetricKeyData = keyData
        } else {
            generateAndSaveSymmetricKey()
        }
    }
    
    private func saveDataToDocumentsDirectory(data: Data, filename: String) {
            let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
            do {
                try data.write(to: fileURL, options: .atomicWrite)
            } catch {
                print("Error saving data to \(filename): \(error)")
            }
        }
        
    private func loadDataFromDocumentsDirectory(filename: String) -> Data? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        return try? Data(contentsOf: fileURL)
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
        print("new")
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
    
    func generateOldPassword(totalLength: Int) {
        print("old")
        let totalLength = max(32, min(totalLength, 64))
        var passwordChars: [String] = []
        var usedLangDescriptions: Set<String> = []
        
        for _ in 0..<(totalLength - 4) {
            guard let charRange = languageOldRanges.randomElement() else { continue }
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
    
    func deleteCredentialsFile() {
        let fileManager = FileManager.default
        let documentsDirectory = getDocumentsDirectory()
        let masterKeyFileURL = documentsDirectory.appendingPathComponent("credentials.json")
        
        do {
            try fileManager.removeItem(at: masterKeyFileURL)
            print("credentials.json file deleted successfully.")
        } catch {
            print("Error deleting credentials.json file: \(error)")
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
    
    //decrypt here
    func loadCredentials() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("credentials.json")
        do {
            // Step 1: Load the encrypted data from the file system
            let encryptedData = try Data(contentsOf: fileURL)
            print("encrypted data \(encryptedData)")
            // Convert the encrypted Data to a base64 encoded string
            let encryptedString = encryptedData.base64EncodedString()
            print("encrypted String" + encryptedString)
            // Step 2: Decrypt the base64 encoded string to get back the original JSON string
            guard let decryptedString = decryptString(encryptedString), let decryptedData = decryptedString.data(using: .utf8) else {
                print("Failed to decrypt credentials")
                return
            }
            print("decrpyted String" + decryptedString)
            
            // Step 3: Decode the JSON string back into your credentials model
            self.credentials = try JSONDecoder().decode([Credentials].self, from: decryptedData)
            print("Credentials loaded successfully.")
        } catch {
            print("Error loading credentials: \(error)")
        }
    }



    func updateLogin(id: String, newMasterPassword: String) {
        if let index = login.firstIndex(where: { $0.id == id }) {
            login[index].masterPassword = encryptString(newMasterPassword)!
            print("Updated login: \(login[index])")
            // Create Sym key
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
    //encrypt here
    func saveCredentials() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("credentials.json")
        
        do {
            // Step 1: Encode your credentials to JSON Data
            let jsonData = try JSONEncoder().encode(credentials)
            // Convert JSON Data to String
            guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                print("Failed to convert JSON data to String")
                return
            }
            // Step 2: Encrypt the JSON String
            guard let encryptedString = encryptString(jsonString) else {
                print("Failed to encrypt credentials")
                return
            }
            // Convert the encrypted String back to Data
            guard let encryptedData = Data(base64Encoded: encryptedString) else {
                print("Failed to convert encrypted string to Data")
                return
            }
            // Step 3: Save the encrypted Data to the file
            try encryptedData.write(to: fileURL, options: .atomic)
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
        if password == decryptString(login.first!.masterPassword) {
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
    
    func encryptString(_ string: String) -> String? {
        guard let data = string.data(using: .utf8),
                let symmetricKey = symmetricKeyData.flatMap({ SymmetricKey(data: $0) }) else { return nil }
        
        do {
            let sealedBox = try AES.GCM.seal(data, using: symmetricKey)
            return sealedBox.combined?.base64EncodedString()
        } catch {
            print("Encryption error: \(error)")
            return nil
        }
    }
        
    func decryptString(_ encryptedString: String) -> String? {
        guard let combinedData = Data(base64Encoded: encryptedString),
                let sealedBox = try? AES.GCM.SealedBox(combined: combinedData),
                let symmetricKey = symmetricKeyData.flatMap({ SymmetricKey(data: $0) }) else { return nil }
        
        do {
            let decryptedData = try AES.GCM.open(sealedBox, using: symmetricKey)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("Decryption error: \(error)")
            return nil
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



