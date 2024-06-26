//
//  CreateMKeyView.swift
//  CSS2 SEMP PM
//
//  Created by John Underwood on 26/3/2024.
//

import SwiftUI

struct CreateMKeyView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorInput = 0
    @State private var showMainPage = false
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "hare.fill")
                    .font(.system(size: 150))
                    .foregroundColor(.black.opacity(0.7))
                Text("SEMP")
                    .font(.title)
                    .bold()
                    .padding()
                Text("Please create a Master Password")
                    .font(.title3)
                    .padding()
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                    .border(.red.opacity(0.4), width: CGFloat(errorInput))
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                    .border(.red.opacity(0.4), width: CGFloat(errorInput))
                Button("Login") {
                    showMainPage = viewModel.matchPasswords(password: password, confirmPassword: confirmPassword)
                    password = ""
                    confirmPassword = ""
                    if showMainPage == false {
                        errorInput = 3
                    }
                    
                }
                .font(.system(size: 28))
                .foregroundColor(.white.opacity(0.9))
                .frame(width: 100, height: 30)
                .background(Color.black.opacity(0.9))
                .cornerRadius(10)
                NavigationLink(destination: LoginView().environmentObject(viewModel), isActive: $showMainPage) {
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    CreateMKeyView().environmentObject(ViewModel())
}
