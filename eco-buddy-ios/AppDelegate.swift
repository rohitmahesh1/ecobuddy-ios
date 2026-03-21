//
//  AppDelegate.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 20/09/23.
//

import Firebase
import Foundation

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
#if DEBUG
      if let storeURL = PersistentStorage.shared.getSQLiteFileURL() {
          print("Storage URL: \(storeURL)")
      }
#endif
      return true
  }
}
