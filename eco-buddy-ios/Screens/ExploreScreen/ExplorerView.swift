//
//  ExplorerView.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 06/10/23.
//

import SwiftUI

struct ExplorerView: View {
    private var cellColors: [Color] = [.ecoPink, .ecoGreen, .ecoSkyBlue]
    
    @State var navigateToDetails = false
    @ObservedObject var viewModel = ExplorerViewModel()
    
    var body: some View {
            VStack {
                ScrollView {
                    ForEach(viewModel.challengesVM) { challengeVM in
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
                        .shadow(color: .black.opacity(0.1), radius: 3.5, x: 0, y: 2)
                        .padding(.top, challengeVM.id == viewModel.challengesVM.first?.id ? 0 : 8)
                        .padding([.leading, .trailing], 22)
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    NavigationLink(
                        destination: ChallengeDetailsView(challenge: viewModel.selectedChallenge).navigationBarBackButtonHidden(),
                        isActive: self.$viewModel.navigateToDetails,
                        label: {
                            Text("")
                        })
                }
                .padding(.top, 22)
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width)
            .navigationBarTitleDisplayMode(.inline)
            .padding(.bottom, -28)
            .background(
                Image("background.explorer")
                    .resizable()
                    .ignoresSafeArea(.all)
                    .padding(.bottom, -28)
            )
            
        
        .onAppear {
            self.viewModel.onAppear()
        }
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text("Explore")
                    .font(.gilroyBold(20))
            }
        })
        
    }
}

#Preview {
    ExplorerView()
}
