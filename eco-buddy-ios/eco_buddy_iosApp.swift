//
//  eco_buddy_iosApp.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 20/09/23.
//

import SwiftUI

@main
struct eco_buddy_iosApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    private var isRunningTests: Bool {
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
    
    var body: some Scene {
        WindowGroup {
            if isRunningTests {
                EmptyView()
            } else {
                NavigationView {
                    ContentView()
                }
            }
        }
    }
}
