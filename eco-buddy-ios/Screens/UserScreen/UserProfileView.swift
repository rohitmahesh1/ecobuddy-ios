//
//  UserProfileView.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 04/10/23.
//

import SwiftUI

struct UserProfileView: View {
    
    private let cellColors: [Color] = [.ecoPink, .ecoGreen, .ecoSkyBlue]
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel: UserProfileViewModel

    init(viewModel: UserProfileViewModel = UserProfileViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            
            VStack(spacing: 14) {
                Image(viewModel.profileImage)
                    .resizable()
                    .frame(width: 92, height: 92)
                    .clipShape(Circle())
                
                Text(viewModel.userName)
                    .font(.gilroyBold(24))
                    .foregroundStyle(.black)
            }
            .padding(.top, 34)
            
            Text("Completed Challenges")
                .font(.gilroyMedium(16))
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 34)
                .padding(.leading, 20)
            
            ScrollView {
                ForEach(viewModel.challengesVM) { challengeVM in
                    CleanEnvCardView(
                        viewModel: CardViewModel(
                            image: challengeVM.challenge.challengeImage,
                            video: challengeVM.challenge.challengeVideoURL,
                            title: challengeVM.challenge.wrappedChallengeTitle,
                            subTitle: challengeVM.challenge.wrappedChallengeDescription,
                            titleColor: self.cellColors.randomElement()!,
                            isCompleted: challengeVM.isSubCompleted,
                            isNavigationHidden: true
                        )
                    )
                    .onTapGesture {
                        challengeVM.onTap?()
                    }
                    .shadow(color: .black.opacity(0.1), radius: 3.5, x: 0, y: 2)
                    .padding(.top, 8)
                    .padding([.leading, .trailing], 20)
                }
                .frame(width: UIScreen.main.bounds.width)
                NavigationLink(
                    destination: ChallengeDetailsView(challenge: viewModel.selectedChallenge).navigationBarBackButtonHidden(),
                    isActive: self.$viewModel.navigateToDetails,
                    label: {
                        Text("")
                    })
                
                NavigationLink(
                    destination: GreetingView(isEditProfile: true).navigationBarBackButtonHidden(),
                    isActive: self.$viewModel.navigateToEditProfile,
                    label: {
                        Text("")
                    })
            }
            Spacer()
            
        }
        .frame(width: UIScreen.main.bounds.width)
        .onBackSwipe {
            presentationMode.wrappedValue.dismiss()
        }
        .onAppear(perform: {
            viewModel.onAppear()
        })
        .edgesIgnoringSafeArea(.bottom)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CustomBackButtonView()
            }
            
            ToolbarItem(placement: .principal) {
                Text("Profile")
                    .font(.gilroyBold(20))
                    .foregroundStyle(.black)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.onEditProfileTap()
                }, label: {
                    Text("Edit")
                        .font(.gilroyMedium(16))
                        .foregroundStyle(.black)
                })
            }
        }
    }
}

#Preview {
    NavigationView {
        UserProfileView()
    }
}
