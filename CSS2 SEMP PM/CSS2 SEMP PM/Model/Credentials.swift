//
//  Credentials.swift
//  CSS2 SEMP PM
//
//  Created by Aljonn Santos on 26/3/2024.
//

import Foundation

struct Credentials{
    private var _email: String
    private var _password: String
    private var _siteTitle: String
    private var _siteAddress: String?
    private var _healthStatus: Int
    private var _breachedStatus: Int
    private var _timeToChange: Int
    private var _notes: String?
    private var _encryptionMethod: String
    
    
    var email: String {
            get {
                return _email
            }
            set {
                _email = newValue
            }
        }

        var password: String {
            get {
                return _password
            }
            set {
                _password = newValue
            }
        }

        var siteTitle: String {
            get {
                return _siteTitle
            }
            set {
                _siteTitle = newValue
            }
        }

        var siteAddress: String? {
            get {
                return _siteAddress
            }
            set {
                _siteAddress = newValue
            }
        }

        var healthStatus: Int {
            get {
                return _healthStatus
            }
            set {
                _healthStatus = newValue
            }
        }

        var breachedStatus: Int {
            get {
                return _breachedStatus
            }
            set {
                _breachedStatus = newValue
            }
        }

        var timeToChange: Int {
            get {
                return _timeToChange
            }
            set {
                _timeToChange = newValue
            }
        }

        var notes: String? {
            get {
                return _notes
            }
            set {
                _notes = newValue
            }
        }
    
    var encryptionMethod: String{
        get{
            return _encryptionMethod
        }
        set{
            _encryptionMethod = newValue
        }
    }
    
    
}
