//
//  DetailView.swift
//  CSS2 SEMP PM
//
//  Created by John Underwood on 30/3/2024.
//

import SwiftUI

var exampleCredentials: Credentials = Credentials(email: "google@gmail.com", password: "1234", siteTitle: "Google", siteAddress: "google.com", healthStatus: 0, breachedStatus: 0, timeToChange: 30, notes: "4 digits", encryptionMethod: "AES")


struct DetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var credentials: Credentials
    @State var isComplete = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "hare.fill")
                    Text("View Credentials")
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
                        Section(header: Text("Credentials")) {
                            TextField("Email", text: $credentials.email)
                                .keyboardType(.emailAddress)
                            SecureField("Password", text: $credentials.password)
                        }
                        Section(header: Text("Encryption Method")) {
                            Menu(credentials.encryptionMethod) {
                                Button("AES"){
                                    credentials.encryptionMethod = "AES"
                                }
                                Button("RSA"){
                                    credentials.encryptionMethod = "RSA"
                                }
                                Button("SHA"){
                                    credentials.encryptionMethod = "SHA"
                                }
                            }
                        }
                        Section(header: Text("Notes")){
                            TextField("Notes", text: Binding<String>( get: { credentials.notes ?? "" }, set: { credentials.notes = $0 }), axis: .vertical)
                                .lineLimit(3...)
                        }
                        Section {
                            Button("Save") {
                                viewModel.updateCredential(id: credentials.id, updatedCredential: credentials)
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
    DetailView(credentials: exampleCredentials).environmentObject(ViewModel())
}
