//
//  CleanEnvCardView.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 03/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardViewModel {
    var image: URL?
    var video: String? = nil
    var title: String
    var subTitle: String
    var titleColor: Color
    var isCompleted: Bool
    var isNavigationHidden: Bool = false
}

struct CleanEnvCardView: View {
    
    var viewModel: CardViewModel
    @State var isImageLoaded = false
    
    var gradientBackgroundView: some View {
        LinearGradient(
            stops: [
                Gradient.Stop(color: .black.opacity(0.56), location: 0.00),
                Gradient.Stop(color: .black.opacity(0), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0, y: 0),
            endPoint: UnitPoint(x: 0.2, y: 0.1)
        )
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                
                if let url = viewModel.image {
                    WebImage(url: url)
                        .resizable()
                        .placeholder(content: {
                            ProgressView()
                                .foregroundStyle(Color.black)
                        })
                        .onSuccess(perform: { _, _, _ in
                            self.isImageLoaded = true
                        })
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 44, height: 150)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 8)
                        )
                        .contentShape(RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            if self.isImageLoaded {
                                gradientBackgroundView
                            }
                        }
                } else {
                    WebImage(url: viewModel.video?.convertUrl?.extractVideoID()?.thumbnailURL.convertUrl)
                        .resizable()
                        .placeholder(content: {
                            ProgressView()
                                .foregroundStyle(Color.black)
                        })
                        .onSuccess(perform: { _, _, _ in
                            self.isImageLoaded = true
                        })
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 44, height: 150)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 8)
                        )
                        .contentShape(RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            if self.isImageLoaded {
                                gradientBackgroundView
                            }
                        }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 72, height: 20)
                        .foregroundStyle(Color.red)
                    Text("Completed")
                        .font(.gilroyMedium(10))
                        .foregroundStyle(.white)
                }
                .opacity(viewModel.isCompleted ? 1 : 0)
                .padding(.top, 10)
                
            }
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.title)
                        .font(.gilroySemiBold(14))
                        .foregroundStyle(viewModel.titleColor)
                    Text(viewModel.subTitle)
                        .lineLimit(1)
                        .font(.gilroyRegular(12))
                }
                
                
                Spacer()
                
                if !viewModel.isNavigationHidden {
                    Image("arrow.forward.icon")
                }
                
            }
            .padding(.top, 4)
            .padding([.leading, .trailing], 8)
            .padding(.bottom, 10)
        }
        .background(Color.white)
        
        .cornerRadius(10, corners: [.allCorners])
    }
}

#Preview {
    CleanEnvCardView(
        viewModel: CardViewModel(
            image: URL(string: ""),
            title: "Join the Fresh Air Fitness Challenge",
            subTitle: "Step outside, get active, and breathe in that clean...",
            titleColor: .ecoPink, isCompleted: false
        )
    )
}
