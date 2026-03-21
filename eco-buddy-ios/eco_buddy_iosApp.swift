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
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
    }
}
