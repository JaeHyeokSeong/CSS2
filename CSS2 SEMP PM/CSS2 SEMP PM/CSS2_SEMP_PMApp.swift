//
//  CSS2_SEMP_PMApp.swift
//  CSS2 SEMP PM
//
//  Created by John Underwood on 23/3/2024.
//

import SwiftUI
import UserNotifications

@main
struct CSS2_SEMP_PMApp: App {
    @StateObject private var viewModel = ViewModel()

    init() {
        configureNotification()
    }

    var body: some Scene {
        WindowGroup {
            OpenAppView()
                .environmentObject(viewModel)
                .onAppear {
                    UNUserNotificationCenter.current().delegate = viewModel
                }
        }
    }

    func configureNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            print("Permission granted: \(granted)")
        }
    }
}
