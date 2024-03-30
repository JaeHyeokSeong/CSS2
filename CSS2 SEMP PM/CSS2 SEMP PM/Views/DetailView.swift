//
//  DetailView.swift
//  CSS2 SEMP PM
//
//  Created by John Underwood on 30/3/2024.
//

import SwiftUI



struct DetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    var credentials: Credentials
    
    var body: some View {
        Text("Email: \(credentials.email)")
        Text("Password: \(credentials.password)")
        Text("Link: \(credentials.siteAddress ?? "")")
    }
}

//#Preview {
//    DetailView(credentials: ).environmentObject(ViewModel())
//}
