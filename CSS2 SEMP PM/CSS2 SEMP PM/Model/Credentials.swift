//
//  Credentials.swift
//  CSS2 SEMP PM
//
//  Created by Aljonn Santos on 26/3/2024.
//

import Foundation

struct Credentials: Hashable, Codable, Identifiable {
//    var email: String
//    var password: String
//    var siteTitle: String
//    var siteAddress: String?
//    var healthStatus: Int
//    var breachedStatus: Int
//    var timeToChange: Int
//    var notes: String?
//    var encryptionMethod: String
    
    var id: String
        
    var email: String
    var password: String
    var siteTitle: String
    var siteAddress: String?
    var healthStatus: Int
    var breachedStatus: Int
    var timeToChange: Int
    var notes: String?
    var encryptionMethod: String
    
    init(email: String, password: String, siteTitle: String, siteAddress: String?, healthStatus: Int, breachedStatus: Int, timeToChange: Int, notes: String?, encryptionMethod: String) {
        self.id = UUID().uuidString
        self.email = email
        self.password = password
        self.siteTitle = siteTitle
        self.siteAddress = siteAddress
        self.healthStatus = healthStatus
        self.breachedStatus = breachedStatus
        self.timeToChange = timeToChange
        self.notes = notes
        self.encryptionMethod = encryptionMethod
    }
}
