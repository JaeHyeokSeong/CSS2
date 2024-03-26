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
                
                VStack{
                    Form {
                        Section(header: Text("Title")){
                            TextField("Title", text: $_title)
                        }
                        Section(header: Text("Credentials")) {
                            TextField("Email", text: $_email)
                                .keyboardType(.emailAddress)
                            SecureField("Password", text: $_password)
                        }
                        Section(header: Text("Site Information")) {
                            TextField("Site Address", text: Binding<String>(
                                get: { _siteAddress ?? "" }, set: { _siteAddress = $0 }
                            ))
                                .keyboardType(.URL)
                        }
                        Section(header: Text("Notes")){
                            TextField("Notes", text: Binding<String>(
                                get: { _notes ?? "" }, set: { _notes = $0 }
                            ), axis: .vertical)
                            .lineLimit(3...)
                            
                        }
                        
                        Section {
                            Button("Add") {
                                // Action when Add button is tapped
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
            }
    }
}

#Preview {
    AddCredentialView()
}
