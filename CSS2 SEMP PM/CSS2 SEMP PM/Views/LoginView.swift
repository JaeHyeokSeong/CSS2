//
//  ContentView.swift
//  CSS2 SEMP PM
//
//  Created by John Underwood on 23/3/2024.
//

import SwiftUI


struct LoginView: View {
    @EnvironmentObject var viewModel: ViewModel
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
                   
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(15)
                        .border(.red.opacity(0.4), width: CGFloat(errorInput))
                    
                    Button("Login") {
                        showLoginScreen = viewModel.authUser(password: password)
                        if showLoginScreen == false{
                            errorInput = 3
                        }
                        password = ""
                    }
                    .font(.system(size: 28))
                    .foregroundColor(.white.opacity(0.9))
                    .frame(width: 100, height: 30)
                    .background(Color.black.opacity(0.9))
                    .cornerRadius(10)
                
                    Button {
                        viewModel.faceIDAuth{ success in
                            if success{
                                showLoginScreen = true
                            } else{
                                errorInput = 3
                            }
                        }
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
            .navigationTitle("Logout")
        }
        
    }
    
}

#Preview {
    LoginView().environmentObject(ViewModel())
}
