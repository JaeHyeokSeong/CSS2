//
//  Credentials.swift
//  CSS2 SEMP PM
//
//  Created by Aljonn Santos on 26/3/2024.
//

import Foundation

struct Credentials: Hashable, Codable {
    private var _email: String
    private var _password: String
    private var _siteTitle: String
    private var _siteAddress: String?
    private var _healthStatus: Int
    private var _breachedStatus: Int
    private var _timeToChange: Int
    private var _notes: String?
    private var _encryptionMethod: String
}
