//
//  Credentials.swift
//  CSS2 SEMP PM
//
//  Created by Aljonn Santos on 26/3/2024.
//

import Foundation

struct Credentials{
    private var email: String
    private var password: String
    private var siteTitle: String
    private var siteAddress: String?
    private var healthStatus: Int
    private var breachedStatus: Int
    private var timeToChange: Int
    private var notes: String?
    
    
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
    
    
}
