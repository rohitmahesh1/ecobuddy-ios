//
//  ChallengesViewModel.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 11/10/23.
//

import Foundation

class ChallengesViewModel: ObservableObject {
    
    struct ChallengeVM: Identifiable {
        let id: String
        var challenge: Challenge
        var onTap: (() -> Void)?
        var isSubCompleted: Bool
    }
    
    let persistentStorage: PersistentStorage
    var category: ChallengeCategory?
    
    var screenTitle: String {
        switch category?.wrappedCategoryId {
            case "1": "Clean Air"
            case "2": "Healthy Living"
            case "3": "Awareness"
            default : ""
        }
    }
    
    var screenDescription: String {
        switch category?.wrappedCategoryId {
            case "1": "Challenge Yourself to Breathe Easy"
            case "2": "Pledge for a Healthier You"
            case "3": "Your guide to Environmental Insights"
            default : ""
        }
    }
    
    @Published var navigateToDetails = false
    @Published var challengesVM: [ChallengeVM] = []
    @Published var selectedChallenge: Challenge?
    
    init(category: ChallengeCategory?, persistentStorage: PersistentStorage = PersistentStorage.shared) {
        self.category = category
        self.persistentStorage = persistentStorage
    }
    
    func fetchChallenges() {
        guard let category else {
            self.challengesVM = []
            self.selectedChallenge = nil
            return
        }

        let challenges = persistentStorage.getChallenges()
        let filteredChallenges = challenges.filter({ challenge in
            category.challengeIds.contains(challenge.wrappedChallengeId) && !challenge.isCompleted
        })
        
        self.selectedChallenge = nil
        self.challengesVM = filteredChallenges.map({ challenge in
            
            return ChallengeVM(
                id: challenge.wrappedChallengeId,
                challenge: challenge,
                onTap: {
                    self.selectedChallenge = challenge
                    self.navigateToDetails = true
                },
                isSubCompleted: challenge.isCompleted
            )
        })
        
    }
    
    func onAppear() {
        self.fetchChallenges()
    }
    
}
