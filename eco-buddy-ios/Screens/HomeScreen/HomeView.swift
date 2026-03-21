//
//  HomeView.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 02/10/23.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("background.home")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Hello \(viewModel.userName),")
                        .font(.gilroyBold(20))
                        .lineLimit(1)
                        .foregroundStyle(.black)
                    Spacer()
                    Image(viewModel.profileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 36, height: 36)
                }
                .onTapGesture {
                    self.viewModel.navigateToUserProfile = true
                }
                .padding(.top, 4)
                .padding([.leading, .trailing], 26)
                
                
                CharacterHintView(
                    image: "turtle",
                    title: "What would you like to see \nin today's environment?",
                    font: .gilroySemiBold(16)
                )
                .padding([.leading, .trailing], 22)
                
                ScrollView {
                    ForEach(Array($viewModel.cardViewModel.enumerated()), id: \.element.wrappedValue.uid) { index, cardViewModel in
                        
                        MenuCardView(title: cardViewModel.wrappedValue.category.wrappedCategoryTitle, description: cardViewModel.wrappedValue.category.wrappedCategoryDescription)
                            .padding(.top, index == 0 ? 10 : 20)
                            .padding([.leading, .trailing], 26)
                            .onTapGesture {
                                cardViewModel.wrappedValue.onTap?()
                            }
                    }
                }
                .navigationBarHidden(true)
                .onAppear(perform: {
                    self.viewModel.loadCategories()
                })
                
                NavigationLink(
                    destination: ChallengesView(viewModel: ChallengesViewModel(category: viewModel.selectedCategory)).navigationBarBackButtonHidden(),
                    isActive: self.$viewModel.navigateToDetail,
                    label: {
                        Text("")
                    })
                
                NavigationLink(
                    destination: UserProfileView().navigationBarBackButtonHidden(),
                    isActive: self.$viewModel.navigateToUserProfile,
                    label: {
                        Text("")
                    })
                
            }
            
        }
    }
}

#Preview {
    HomeView()
}
