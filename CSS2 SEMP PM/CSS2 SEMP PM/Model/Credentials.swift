//
//  Credentials.swift
//  CSS2 SEMP PM
//
//  Created by Aljonn Santos on 26/3/2024.
//

import Foundation

struct Credentials: Hashable, Codable, Identifiable {
    var id: String
        
    var email: String
    var password: String
    var siteTitle: String
    var siteAddress: String?
    var healthStatus: Int
    var breachedStatus: Int
    var date: Date
    var notes: String?
    var daysCount: Int = 30
    
    
    init(email: String, password: String, siteTitle: String, siteAddress: String?, healthStatus: Int, breachedStatus: Int, date: Date, notes: String?) {
        self.id = UUID().uuidString
        self.email = email
        self.password = password
        self.siteTitle = siteTitle
        self.siteAddress = siteAddress
        self.healthStatus = healthStatus
        self.breachedStatus = breachedStatus
        self.date = date
        self.notes = notes
    }
}
