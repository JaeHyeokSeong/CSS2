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
                
            VStack(spacing: 15) {
                    HStack(spacing: 20) {
                        Text("Title:")
                        TextField("Title", text: $_title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .shadow(radius: 5)
                    }
                    
                    HStack(spacing: 20) {
                        Text("Email:")
                        TextField("Email", text: $_email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .shadow(radius: 5)
                    }
                    
                    HStack (spacing: 20){
                        Text("Password:")
                        SecureField("Password", text: $_password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .shadow(radius: 5)
                    }
                    
                    HStack (spacing: 20){
                        Text("Site Address:")
                        TextField("Site Address", text: Binding<String>(
                            get: { _siteAddress ?? "" }, set: { _siteAddress = $0 }
                        ))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .shadow(radius: 5)
                    }
                    
                    Button("Add") {
                        // Action for the button
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    .shadow(radius: 5)
                }
                .padding()

                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    AddCredentialView()
}
