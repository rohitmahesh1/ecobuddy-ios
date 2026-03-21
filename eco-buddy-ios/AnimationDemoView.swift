//
//  AnimationDemoView.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 04/10/23.
//

import SwiftUI

struct AnimationDemoView: View {
    
    let maxHeight = UIScreen.main.bounds.height / 4
    @State var offSet: CGFloat = .zero
    var topEdge: CGFloat
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                 
                GeometryReader(content: { geometry in
                    VStack(alignment: .leading, spacing: 15) {
                        VStack(spacing: 14) {
                            Image("avatar")
                                .resizable()
                                .frame(width: 92, height: 92)
                                .clipShape(Circle())
                            
                            Text("Ava")
                                .font(.gilroyBold(24))
                                .foregroundStyle(.black)
                        }
                        .padding(.bottom)
                        .opacity(self.getOpacity())
                    }
                    
                    .padding(.top, topEdge)
                    .frame(maxWidth: .infinity)
                    .frame(height: getHeaderHeight(), alignment: .bottom)
                    .background(Color.yellow)
                    
                })
                .frame(height: maxHeight)
                .offset(y: -offSet)
                .zIndex(1)
                
                ForEach(0..<100) { _ in
                    Text("hey")
                }
                .zIndex(0)
                
            }
            .modifier(OffsetModifier(offSet: $offSet))
        }
        
        .coordinateSpace(name: "SCROLL")
    }
    
    func getHeaderHeight() -> CGFloat {
        let topHeight = maxHeight + offSet
        
        return topHeight > (80 + topEdge) ? topHeight : (80 + topEdge)
    }
    
    func getOpacity() -> CGFloat {
        let progress = -offSet / 70
        let opacity = 1 - progress
        
        return offSet < 0 ? opacity : 1
    }
}

//#Preview {
//    AnimationDemoView(, topEdge: <#CGFloat#>)
//}
