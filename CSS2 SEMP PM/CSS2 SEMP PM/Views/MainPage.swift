//
//  MainPage.swift
//  CSS2 SEMP PM
//
//  Created by Jae Hyeok Seong on 24/3/2024.
//

import SwiftUI

struct MainPage: View {
//    @EnvironmentObject var viewModel: ViewModel
//    @State private var searchText: String = ""
//    @State private var showingAddCredentialView = false
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                ZStack(alignment: .leading) {
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke(Color.gray, lineWidth: 1)
//                    
//                    HStack {
//                        Image(systemName: "magnifyingglass")
//                            .foregroundColor(.gray)
//                            .padding(.leading, 8)
//                        TextField("Search", text: $searchText)
//                            .padding(.horizontal, 8)
//                    }
//                }
//                .frame(height: 40)
//                .frame(width: 360)
//                .padding(.bottom, 20)
//                Spacer()
//                
//                List($viewModel.filteredCredentials(searchText: searchText), id: \.id) { credential in
//                    NavigationLink(destination: DetailView(credential: credential)) {
//                        VStack(alignment: .leading) {
//                            Text("Email: \(credential.email)")
//                            Text("Password: \(credential.password)")
//                            Text("Link: \(credential.siteAddress)")
//                        }
//                        .padding(.vertical, 10)
//                    }
//                }
//                
//            }
//            .navigationBarTitle("Passwords", displayMode: .inline)
//            .navigationBarItems(trailing:
//                Button(action: {
//                    showingAddCredentialView = true
//                }) {
//                    Image(systemName: "plus")
//                }
//            )
//            .sheet(isPresented: $showingAddCredentialView) {
//                AddCredentialView().environmentObject(viewModel)
//            }
//        }
//    }
    @EnvironmentObject var viewModel: ViewModel
        @State private var searchText: String = ""
        @State private var showingAddCredentialView = false
        @State private var filteredCredentials: [Credentials] = []
        
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
                                Text("Link: \(credential.siteAddress ?? "")")
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
                    AddCredentialView().environmentObject(viewModel)
                }
                .onAppear {
                    updateFilteredCredentials()
                }
                .onChange(of: searchText) { _ in
                    updateFilteredCredentials()
                }
            }
        }
        
        func updateFilteredCredentials() {
            filteredCredentials = viewModel.filteredCredentials(searchText: searchText)
        }
}


struct DetailView: View {
    var credential: Credentials
    
    var body: some View {
        VStack {
            Text("Email: \(credential.email)")
            Text("Password: \(credential.password)")
            Text("Link: \(credential.siteAddress)")
        }
        .navigationBarTitle("Detail")
    }
}

#Preview {
    MainPage().environmentObject(ViewModel())
}


