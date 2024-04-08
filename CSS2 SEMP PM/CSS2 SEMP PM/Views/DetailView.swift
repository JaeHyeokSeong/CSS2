//
//  DetailView.swift
//  CSS2 SEMP PM
//
//  Created by John Underwood on 30/3/2024.
//

import SwiftUI

var exampleCredentials: Credentials = Credentials(email: "google@gmail.com", password: "1234", siteTitle: "Google", siteAddress: "google.com", healthStatus: 0, breachedStatus: 0, date: Date(), notes: "4 digits")


struct DetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var credentials: Credentials
    @State var isComplete = false
    @State var isEditing = false
    @State var editButton = "Edit"
    @State var passwordChanged = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    if(!isEditing){
                        Button("Done") {
                            isComplete = true
                        }
                    }
                    Spacer()
                    Image(systemName: "hare.fill")
                    Text("View Credentials")
                    Spacer()
                    Button(editButton){
                        isEditing.toggle()
                        if(editButton == "Edit"){
                            editButton = "Confirm"
                        } else if(editButton == "Confirm"){
                            editButton = "Edit"
                            if(passwordChanged){
                                credentials.daysCount = 30
                                credentials.breachedStatus = 0
                            }
                            viewModel.updateCredential(id: credentials.id, updatedCredential: credentials)
                        }
                        
                    }
                }
                .padding()
                VStack{
                    Form {
                        Section(header: Text("Site Information")){
                            TextField("Title", text: $credentials.siteTitle)
                            TextField("Site Address", text: Binding<String>( get: { credentials.siteAddress ?? "" }, set: { credentials.siteAddress = $0 }
                                                                           ))
                            .keyboardType(.URL)
                        }
                            .disabled(!isEditing)
                        
                        Section(header: Text("Credentials")) {
                            TextField("Email", text: $credentials.email)
                                .keyboardType(.emailAddress)
                            HStack {
                                if(isEditing){
                                    TextField("Password", text: $credentials.password)
                                } else{
                                    SecureField("Password", text: $credentials.password)
                                }
                                if(editButton == "Confirm"){
                                    Menu("Gen"){
                                        Button ("NewChars") {
                                            viewModel.generatePassword(totalLength: 64)
                                            credentials.password = viewModel.generatedPassword
                                            passwordChanged = true
                                        }
                                        Button ("OldChars") {
                                            viewModel.generateOldPassword(totalLength: 64)
                                            credentials.password = viewModel.generatedPassword
                                            passwordChanged = true
                                        }
                                    }
                                }
                            }
                            
                                
                        }
                            .disabled(!isEditing)
                        
                        Section(header: Text("Notes")){
                            TextField("Notes", text: Binding<String>( get: { credentials.notes ?? "" }, set: { credentials.notes = $0 }), axis: .vertical)
                                .lineLimit(3...)
                        }
                        .disabled(!isEditing)
                        
                        Section {
                            Button("Copy") {
                                UIPasteboard.general.string = credentials.password
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .disabled(false)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.blue)
                            }
                        
                        Section {
                            Button("Delete") {
                                viewModel.deleteCredential(id: credentials.id)
                                isComplete = true
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .disabled(false)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.red)
                            }
                        
                        Section {
                            Menu ("Admin Tools") {
                                Button ("Change Password Time Till Change") {
                                    credentials.daysCount = 0
                                }
                                Button ("Change Breached") {
                                    credentials.breachedStatus = 1
                                }
                            }
                        }
                        .disabled(!isEditing)
                        
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isComplete){
                MainPage().environmentObject(viewModel)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(false)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    DetailView(credentials: exampleCredentials).environmentObject(ViewModel())
}
