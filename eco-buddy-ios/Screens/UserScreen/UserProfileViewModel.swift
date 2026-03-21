//
//  UserProfileViewModel.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 12/10/23.
//

import SwiftUI

class UserProfileViewModel: ObservableObject {
    
    struct ChallengeVM: Identifiable {
        var id = UUID()
        var challenge: Challenge
        var isSubCompleted: Bool
        var onTap: (() -> Void)?
    }
    
    @AppStorage("userName") var userName: String = ""
    @AppStorage("profileImage") var profileImage: String = ""

    @Published var selectedChallenge: Challenge?
    @Published var challengesVM: [ChallengeVM] = []
    @Published var navigateToDetails = false
    @Published var navigateToEditProfile = false
    
    private let persistentStorage: PersistentStorage = PersistentStorage()
    
    private func getCompletedChallenges() {
        let challenges = persistentStorage.getChallenges()
        let filteredChallenges = challenges.filter({ $0.isCompleted })
        
        self.challengesVM = filteredChallenges.map { challenge in
            return ChallengeVM(
                challenge: challenge,
                isSubCompleted: challenge.isCompleted,
                onTap: {
                    /*
                    self.selectedChallenge = challenge
                    self.navigateToDetails = true
                     */
                }
            )
        }
    }
    
    func onEditProfileTap() {
        self.navigateToEditProfile = true
    }
    
    func onAppear() {
        self.getCompletedChallenges()
    }
    
}
