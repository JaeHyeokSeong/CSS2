//
//  MainPage.swift
//  CSS2 SEMP PM
//
//  Created by Jae Hyeok Seong on 24/3/2024.
//

import SwiftUI

struct MainPage: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var searchText: String = ""
    @State private var showingAddCredentialView = false
    @State private var filteredCredentials: [Credentials] = []
        
    var body: some View {
        NavigationStack {
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
                    NavigationLink(destination: DetailView(credentials: credential).environmentObject(viewModel)) {
                        HStack() {
                            Text("\(credential.siteTitle)")
                            Spacer()
                            VStack{
                                // healthStatus == 0 -> good
                                // healthStatus == 1 -> normal
                                // healthStatus == 2 -> bad
                                if(credential.healthStatus == 0) {
                                    Image(systemName: "checkmark.circle.fill")
                                } else if(credential.healthStatus == 1) {
                                    Image(systemName: "exclamationmark.circle.fill")
                                } else if(credential.healthStatus == 2) {
                                    Image(systemName: "xmark.circle.fill")
                                } else {
                                    Text("Invalid health status")
                                }
                                
                                // breachedStatus has two status
                                // 0 -> safe
                                // 1 -> unsafe
                                if(credential.breachedStatus == 0) {
                                    Image(systemName: "shield.fill")
                                        .foregroundColor(.green)
                                } else if(credential.breachedStatus == 1) {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundColor(.red)
                                } else {
                                    Text("Invalid breached status")
                                }
                            }
                            VStack{
                                Text("\(credential.date)")
                                Text("\(credential.encryptionMethod)")
                            }
                        }
                        //.padding(.vertical, 10)
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
        .navigationBarHidden(true)
    }
        
    func updateFilteredCredentials() {
        filteredCredentials = viewModel.filteredCredentials(searchText: searchText)
    }
}

#Preview {
    MainPage().environmentObject(ViewModel())
}


