//
//  DetailView.swift
//  CSS2 SEMP PM
//
//  Created by John Underwood on 30/3/2024.
//

import SwiftUI

var exampleCredentials: Credentials = Credentials(email: "", password: "", siteTitle: "", siteAddress: nil, healthStatus: 0, breachedStatus: 0, timeToChange: 30, notes: nil, encryptionMethod: "")


struct DetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    var credentials: Credentials

    
    var body: some View {
        Text("Email: \(credentials.email)")
        Text("Password: \(credentials.password)")
        Text("Link: \(credentials.siteAddress ?? "")")
    }
}

#Preview {
    DetailView(credentials: exampleCredentials).environmentObject(ViewModel())
}
