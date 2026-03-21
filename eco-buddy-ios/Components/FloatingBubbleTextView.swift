//
//  FloatingBubbleTextView.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 02/10/23.
//

import SwiftUI

struct FloatingBubbleTextView: View {
    
    var text: String
    
    var body: some View {
        VStack(spacing: UIDevice.hasTopNotch ? 12 : 6) {
            VStack {
                Text(text)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
                    .font(.gilroySemiBold(18))
                    .padding([.top, .bottom], 14)
                    .padding([.leading, .trailing], 34)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .inset(by: -0.64)
                    .stroke(Color(red: 0.92, green: 0.27, blue: 0.2), lineWidth: 1.28)
            )
            .background(Color.white.cornerRadius(10, corners: .allCorners))
            
            Image("image.bubble")
        }
        
       
    }
}

#Preview {
    FloatingBubbleTextView(text: "Hi, My name is Buddy!\nWhat's yours?!")
}
