//
//  AddCredentialView.swift
//  CSS2 SEMP PM
//
//  Created by Aljonn Santos on 26/3/2024.
//

import SwiftUI

struct AddCredentialView: View {
    @EnvironmentObject var viewModel: ViewModel
@State var credential: Credentials = Credentials(email: "", password: "", siteTitle: "", siteAddress: nil, healthStatus: 0, breachedStatus: 0, timeToChange: 30, notes: nil, encryptionMethod: "")
@State var encryptSelection = "Select Encryption Method"
@State var isComplete = false
    
var body: some View {
    NavigationStack {
                VStack {
                        HStack {
                            Image(systemName: "hare.fill")
                            Text("Add Credentials")
                        }
                        .padding()
                        
                        VStack{
                            Form {
                                Section(header: Text("Site Information")){
                                    TextField("Title", text: $credential.siteTitle)
                                    TextField("Site Address", text: Binding<String>(
                                        get: { credential.siteAddress ?? "" }, set: { credential.siteAddress = $0 }
                                    ))
                                        .keyboardType(.URL)
                                }
                                Section(header: Text("Credentials")) {
                                    TextField("Email", text: $credential.email)
                                        .keyboardType(.emailAddress)
                                    SecureField("Password", text: $credential.password)
                                }
                                Section(header: Text("Encryption Method")) {
                                    Menu(encryptSelection) {
                                        Button("AES"){
                                            encryptSelection = "AES"
                                        }
                                        Button("RSA"){
                                            encryptSelection = "RSA"
                                        }
                                        Button("SHA"){
                                            encryptSelection = "SHA"
                                        }
                                    }
                                }
                                Section(header: Text("Notes")){
                                    TextField("Notes", text: Binding<String>(
                                        get: { credential.notes ?? "" }, set: { credential.notes = $0 }
                                    ), axis: .vertical)
                                    .lineLimit(3...)
                                    
                                }
                                Section {
                                    Button("Add") {
                                        //credentials.append(credential) //need to check if all fields are filled.
                                        isComplete = true
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .navigationDestination(isPresented: $isComplete){
                                        MainPage().environmentObject(viewModel)
                                            .navigationBarBackButtonHidden()
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
        }

#Preview {
    AddCredentialView().environmentObject(ViewModel())
}
