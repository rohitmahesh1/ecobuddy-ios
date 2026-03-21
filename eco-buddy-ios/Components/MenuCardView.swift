//
//  MenuCardView.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 02/10/23.
//

import SwiftUI

struct MenuCardView: View {
    var title: String
    var description: String
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .foregroundStyle(.black)
                    .font(.gilroySemiBold(16))
                    .lineSpacing(5)
                    .padding(.top, 14)
                Text(description)
                    .lineSpacing(5)
                    .font(.gilroyRegular(16))
                    .foregroundStyle(.black)
                    .padding(.bottom, 14)
            }
            .padding(.leading, 16)
            Spacer()
            Image("arrow.forward.icon")
                .padding(.trailing, 18)
        }
        .background(
            Rectangle()
                .foregroundColor(.clear)
                .background(.white)
                .cornerRadius(14)
        )
    }
}

#Preview {
    MenuCardView(title: "Clean environment random text goes here line spacing is fine", description: "Take on fun challenges that promote clean air and healthy living")
}
