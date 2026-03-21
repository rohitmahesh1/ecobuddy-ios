//
//  CleanEnvironmentView.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 02/10/23.
//

import SwiftUI

struct ChallengesView: View {
    
    private var cellColors: [Color] = [.ecoPink, .ecoGreen, .ecoSkyBlue]
    
    @ObservedObject var viewModel: ChallengesViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    init(viewModel: ChallengesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("background.challenge")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack {
                CharacterHintView(
                    image: "turtle.clear",
                    title: viewModel.screenDescription,
                    font: .gilroyBold(16)
                )
                .padding(.top, 12)
                .padding([.leading, .trailing], 16)
                
                if viewModel.challengesVM.count == 0 {
                    Spacer()
                    Text("Congrats! \nYou have completed all challenges.")
                        .font(.gilroyMedium(14))
                        .padding(.top, 120)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                }
                
                ScrollView {
                    ForEach(0..<viewModel.challengesVM.count, id: \.self) { index in
                        let challengeVM = viewModel.challengesVM[index]
                
                        CleanEnvCardView(
                            viewModel: CardViewModel(
                                image: challengeVM.challenge.challengeImage,
                                video: challengeVM.challenge.challengeVIdeoURL,
                                title: challengeVM.challenge.wrappedChallengeTitle,
                                subTitle: challengeVM.challenge.wrappedChallengeDescription,
                                titleColor: self.cellColors.randomElement()!,
                                isCompleted: challengeVM.isSubCompleted
                            )
                        )
                        .onTapGesture {
                            challengeVM.onTap?()
                        }
                        .frame(width: UIScreen.main.bounds.width - 44)
                        .shadow(color: .black.opacity(0.1), radius: 3.5, x: 0, y: 2)
                        .padding(.top, 8)
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    
                    NavigationLink(
                        destination: ChallengeDetailsView(challenge: viewModel.selectedChallenge).navigationBarBackButtonHidden(),
                        isActive: self.$viewModel.navigateToDetails,
                        label: {
                            Text("")
                        })
                }
                .onBackSwipe {
                    presentationMode.wrappedValue.dismiss()
                }
                .onAppear {
                    self.viewModel.onAppear()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text(viewModel.screenTitle)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.gilroyBold(20))
            }
            
            ToolbarItem(placement: .topBarLeading) {
                CustomBackButtonView()
            }
        })
        
    }
}
