//
//  CustomTabbarView.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 02/10/23.
//

import SwiftUI

enum TabbarViewType {
    case home
    case explore
    case pledge
}

struct CustomTabbarView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedTabbar: TabbarViewType
    
    var body: some View {
        VStack{
            ZStack {
                Rectangle()
                    .foregroundStyle(.white)
                    .cornerRadius(26, corners: [.topLeft, .topRight])
                
                HStack {
                    VStack {
                        Image("tab.home.icon")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(10)
                            .contentShape(Rectangle())
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 6).fill(selectedTabbar == .home ? Color.greenMain : .clear)
                    )
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        self.selectedTabbar = .home
                    }
                    
                    Spacer()
                    
                    VStack {
                        Image("tab.explore.icon")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(10)
                            .contentShape(Rectangle())
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 6).fill(selectedTabbar == .explore ? Color.greenMain : .clear)
                    )
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        self.selectedTabbar = .explore
                    }
                    
                    Spacer()
                    
                    VStack {
                        Image("tab.pledge.icon")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(10)
                            .contentShape(Rectangle())
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 6).fill(selectedTabbar == .pledge ? Color.greenMain : .clear)
                    )
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        self.selectedTabbar = .pledge
                    }
                }
                
                .frame(height: 50)
                .padding([.trailing, .leading], 46)
            }
        }
        .frame(height: 82)
    }
    
}

#Preview {
    CustomTabbarView(selectedTabbar: .constant(.home))
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
