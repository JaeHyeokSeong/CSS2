//
//  AddCredentialView.swift
//  CSS2 SEMP PM
//
//  Created by Aljonn Santos on 26/3/2024.
//

import SwiftUI

struct AddCredentialView: View {
    @State var _title: String = ""
    @State var _email: String = ""
    @State var _password: String = ""
    @State var _siteTitle: String = ""
    @State var _siteAddress: String? = ""
//    @State var _healthStatus: Int = ""
//    @State var _reachedStatus: Int = ""
//    @State var _timeToChange: Int = ""
    @State var _notes: String? = ""
    @State var _encryptionMethod: String = ""
    
    var body: some View {
        VStack {
                HStack {
                    Image(systemName: "hare.fill")
                    Text("Add Credentials")
                }
                .padding()
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("Title:")
                            .padding(.trailing, 10.0)
                        TextField("Title", text: $_title)
                            .frame(width:200.0)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack {
                        Text("Email:")
                            .padding(.trailing, 10.0)
                        TextField("Email", text: $_email)
                            .frame(width:200.0)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack {
                        Text("Password:")
                            .padding(.trailing, 10.0)
                        TextField("Password", text: $_password)
                            .frame(width:200.0)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    HStack {
                        Text("Site Address:")
                            .padding(.trailing, 10.0)
                        TextField("Site Address", text: $_siteAddress)
                            .frame(width:200.0)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    
                    Button("Add") {
                        
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    AddCredentialView()
}
