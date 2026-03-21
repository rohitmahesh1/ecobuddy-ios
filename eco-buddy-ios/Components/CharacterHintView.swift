//
//  CharacterHintView.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 03/10/23.
//

import SwiftUI

struct CharacterHintView: View {
    var image: String
    var title: String
    var font: Font = .gilroyMedium(16)
    var titleColor: Color = Color.black
    var body: some View {
        HStack(spacing: 6) {
            GIFView(type: .name(image))
                .frame(width: 111, height: 109)
            
            Text(title)
                .font(font)
                .lineSpacing(6)
                .foregroundStyle(titleColor)
            
            Spacer()
            
        }
    }
}

//#Preview {
//    CharacterHintView()
//}
