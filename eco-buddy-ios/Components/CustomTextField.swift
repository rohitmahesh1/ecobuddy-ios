//
//  CustomTextField.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 02/10/23.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var txt: String
    
    var body: some View {
        VStack {
            TextField("Enter your name", text: $txt)
                .foregroundStyle(Color.black)
                .font(.gilroyMedium(14))
                .padding([.leading, .trailing], 18)
        }
        .frame(height: 50)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: -0.5)
                .stroke(.black.opacity(0.2), lineWidth: 1)
        )
    }
}

#Preview {
    CustomTextField(txt: .constant(""))
}
