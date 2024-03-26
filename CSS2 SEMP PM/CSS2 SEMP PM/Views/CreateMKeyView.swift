//
//  CreateMKeyView.swift
//  CSS2 SEMP PM
//
//  Created by John Underwood on 26/3/2024.
//

import SwiftUI

struct CreateMKeyView: View {
    @State var password = ""
    @State var confirmPassword = ""
    var body: some View {
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
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
        }
    }
    
    func matchPasswords() -> Bool {
        return password == confirmPassword
    }
}



#Preview {
    CreateMKeyView()
}
