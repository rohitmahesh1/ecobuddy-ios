//
//  SplashScreen.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 02/10/23.
//

import SwiftUI

struct SplashScreen: View {
    
    var body: some View {

            VStack {
                
                VStack {
                    HStack {
                        Text("ECO")
                            .font(.mochiyPopOneRegular(30))
                            .foregroundStyle(Color(red: 0.04, green: 0.64, blue: 0.44))
                        Text("HEALTH")
                            .font(.mochiyPopOneRegular(30))
                            .foregroundStyle(Color.redMain)
                    }
                    
                    GIFView(type: .name("greeting.turtle"))
                        .frame(width: 273, height: 269)
                }
                
                
                .padding(.top, UIDevice.hasTopNotch ? 28 : 10)
                Spacer()
 
                Spacer()

            }
            
            .background(
                Image("background.home")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width)
                    .edgesIgnoringSafeArea(.all)
            )
    }
}

#Preview {
    SplashScreen()
}
