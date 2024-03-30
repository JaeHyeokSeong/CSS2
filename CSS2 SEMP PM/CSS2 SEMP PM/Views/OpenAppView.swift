//
//  OpenAppView.swift
//  CSS2 SEMP PM
//
//  Created by John Underwood on 23/3/2024.
//

import SwiftUI

struct OpenAppView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var isActive = false
    @State private var size = 0.7
    @State private var opacity = 0.3
    
    var body: some View {
        if isActive {
            if viewModel.login.first?.masterPassword == nil {
                CreateMKeyView().environmentObject(viewModel)
            }
            else {
                LoginView().environmentObject(viewModel)
            }
        }
        else {
            VStack {
                VStack {
                    
                    Image(systemName: "hare.fill")
                        .font(.system(size: 150))
                        .foregroundColor(.black.opacity(0.7))
                    Text("SEMP")
                        .font(Font.custom("Baskerville-Bold", size: 24))
                    Text("Password Manager")
                        .font(Font.custom("Baskerville-Bold", size: 24))
                    // Create Loading animation
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    OpenAppView().environmentObject(ViewModel())
}
