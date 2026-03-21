//
//  CustomButtonView.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 02/10/23.
//

import SwiftUI

struct CustomButtonView: View {
    
    var onTap: (() -> Void)? = nil
    var title: String
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.greenMain)
                Text(self.title)
                    .font(.gilroySemiBold(16))
                    .foregroundStyle(.white)
            }
            .frame(height: 50)
        }

    }
}

#Preview {
    CustomButtonView(title: "Submit")
}
