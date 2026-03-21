//
//  SubtaskCell.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 03/10/23.
//

import SwiftUI



struct SubtaskCell: View {
    
    var checkBox = false
    var onTap: (() -> ())?
    var count: String
    var title: String
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.greenMain.opacity(0.3))
                Text(count)
                    .font(.gilroySemiBold(14))
                    .foregroundStyle(Color.greenMain)
            }
            .padding(8)
            
            Text(LocalizedStringKey(title))
                .lineSpacing(4)
                .padding([.top, .bottom])
                .padding([.leading, .trailing], 2)
                .font(.gilroyMedium(14))
            
            Spacer()
            
            Image(checkBox ? "image.checkbox.selected" : "image.checkbox.deselected")
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30)
                .clipped()
                .padding(8)
                .onTapGesture {
                    self.onTap?()
                }
            
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.grayBackground)
        )
    }
}

#Preview {
    SubtaskCell(count: "1", title: "dsaf")
}
