//
//  MainPage.swift
//  CSS2 SEMP PM
//
//  Created by Jae Hyeok Seong on 24/3/2024.
//

import SwiftUI

struct Credential: Identifiable {
    var id = UUID()
    var email: String
    var password: String
}

struct MainPage: View {
    @State private var searchText: String = ""
    
    let credentials: [Credential] = [
        Credential(email: "email1@gmail.com", password: "password1"),
        Credential(email: "email2@gmail.com", password: "password2"),
        Credential(email: "email3@gmail.com", password: "password3")
    ]
    
    var filteredCredentials: [Credential] {
        let lowercasedSearchText = searchText.lowercased()
        if searchText.isEmpty {
            return credentials
        } else {
            return credentials.filter {
                $0.email.lowercased().contains(lowercasedSearchText) ||
                $0.password.lowercased().contains(lowercasedSearchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Spacer()
                
                List(filteredCredentials) { credential in
                    NavigationLink(destination: DetailView(credential: credential)) {
                        VStack(alignment: .leading) {
                            Text("Email: \(credential.email)")
                            Text("Password: \(credential.password)")
                        }
                        .padding(.vertical, 10)
                    }
                }
                .navigationBarTitle("Credentials")
            }
        }
    }
}


struct DetailView: View {
    var credential: Credential
    
    var body: some View {
        VStack {
            Text("Email: \(credential.email)")
            Text("Password: \(credential.password)")
        }
        .navigationBarTitle("Detail")
    }
}

#Preview {
    MainPage()
}


