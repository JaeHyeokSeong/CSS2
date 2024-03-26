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
    var link: String
}

struct MainPage: View {
    @State private var searchText: String = ""
    @State private var showingAddCredentialView = false
    
    let credentials: [Credential] = [
        Credential(email: "email1@gmail.com", password: "password1", link: "www.google.com"),
        Credential(email: "email2@gmail.com", password: "password2", link: "www.google.com"),
        Credential(email: "email3@gmail.com", password: "password3", link: "www.naver.com"),
        Credential(email: "email3@gmail.com", password: "password4", link: "www.naver.com"),
        Credential(email: "email3@gmail.com", password: "password5", link: "www.naver.com"),
        Credential(email: "email3@gmail.com", password: "password6", link: "www.naver.com"),
        Credential(email: "email3@gmail.com", password: "password7", link: "www.naver.com"),
        Credential(email: "email3@gmail.com", password: "password8", link: "www.naver.com"),
        Credential(email: "email3@gmail.com", password: "password9", link: "www.naver.com"),
        Credential(email: "email3@gmail.com", password: "password10", link: "www.naver.com")
    ]
    
    var filteredCredentials: [Credential] {
        let lowercasedSearchText = searchText.lowercased()
        if searchText.isEmpty {
            return credentials
        } else {
            return credentials.filter {
                $0.email.lowercased().contains(lowercasedSearchText) ||
                $0.password.lowercased().contains(lowercasedSearchText)
                    ||
                $0.link.lowercased().contains(lowercasedSearchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        TextField("Search", text: $searchText)
                            .padding(.horizontal, 8)
                    }
                }
                .frame(height: 40)
                .frame(width: 360)
                .padding(.bottom, 20)
                Spacer()
                
                List(filteredCredentials) { credential in
                    NavigationLink(destination: DetailView(credential: credential)) {
                        VStack(alignment: .leading) {
                            Text("Email: \(credential.email)")
                            Text("Password: \(credential.password)")
                            Text("Link: \(credential.link)")
                        }
                        .padding(.vertical, 10)
                    }
                }
                
            }
            .navigationBarTitle("Passwords", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    showingAddCredentialView = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddCredentialView) {
                AddCredentialView()
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
            Text("Link: \(credential.link)")
        }
        .navigationBarTitle("Detail")
    }
}

#Preview {
    MainPage()
}


