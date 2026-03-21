//
//  ContentView.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 20/09/23.
//

import SwiftUI
import FirebaseCrashlytics

struct ContentView: View {
    
    @AppStorage("userName") var userName: String = ""
    @State var previewState = true
    
    var body: some View {
        VStack {
            if self.previewState {
                splashScreen
            } else {
                if userName.isEmpty {
                    GreetingView(isEditProfile: false)
                } else {
                    TabbarView().navigationBarBackButtonHidden()
                }
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.previewState = false
            }
        })
    }
    
    var splashScreen: some View {
        SplashScreen()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
