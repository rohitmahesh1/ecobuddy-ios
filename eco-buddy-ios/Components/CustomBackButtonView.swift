//
//  CustomBackButtonView.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 03/10/23.
//

import SwiftUI

struct CustomBackButtonView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 41, height: 41)
                .foregroundColor(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color.greenMain, lineWidth: 1)
                )
            
            Image("back.arrow.custom")
        }
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }
}


#Preview {
    CustomBackButtonView()
}
