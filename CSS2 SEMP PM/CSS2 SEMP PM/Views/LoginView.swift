//
//  ContentView.swift
//  CSS2 SEMP PM
//
//  Created by John Underwood on 23/3/2024.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var username = ""
    @State private var password = ""
    @State private var errorInput = 0
    @State private var showLoginScreen = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack {
                    Image(systemName: "hare.fill")
                        .font(.system(size: 150))
                        .foregroundColor(.black.opacity(0.7))
                    Text("SEMP")
                        .font(.title)
                        .bold()
                        .padding()
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(15)
                        .border(.red.opacity(0.4), width: CGFloat(errorInput))
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(15)
                        .border(.red.opacity(0.4), width: CGFloat(errorInput))
                    
                    Button("Login") {
                        authUser(username: username, Password: password)
                    }
                    .font(.system(size: 28))
                    .foregroundColor(.white.opacity(0.9))
                    .frame(width: 100, height: 30)
                    .background(Color.black.opacity(0.9))
                    .cornerRadius(10)
                    
                    Button {
                        faceIDAuth()
                    }
                    label: {
                        Image(systemName: "faceid")
                    }
                    .font(.system(size: 40))
                     
                    
                    NavigationLink(destination: MainPage().environmentObject(viewModel), isActive: $showLoginScreen) {
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    func authUser(username: String, Password: String) {
        // Implement database connection
        
        // testing purposes
        if username.lowercased() == "johnduw@gmail.com" {
            if password == "TestingPassword123!@#" {
                showLoginScreen = true
            }
        }
        else {
            errorInput = 3
        }
    }
    
    func faceIDAuth() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Login with Face ID") { success, authenticationError in
                if success {
                    showLoginScreen = true
                } else {
                    errorInput = 3
                }
                
            }
        } else {
            
        }
    }
}

#Preview {
    LoginView().environmentObject(ViewModel())
}
