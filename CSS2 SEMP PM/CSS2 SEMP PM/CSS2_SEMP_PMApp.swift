//
//  CSS2_SEMP_PMApp.swift
//  CSS2 SEMP PM
//
//  Created by John Underwood on 23/3/2024.
//

import SwiftUI

@main
struct CSS2_SEMP_PMApp: App {
    @StateObject private var viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            OpenAppView().environmentObject(viewModel)
        }
    }
}
