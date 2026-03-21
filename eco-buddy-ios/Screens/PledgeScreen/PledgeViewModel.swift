//
//  PledgeViewModel.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 23/10/23.
//

import Foundation

class PledgeViewModel: ObservableObject {
    
    struct ChallengeVM: Identifiable {
        let id = UUID().uuidString
        var challenge: Challenge
        var onTap: (() -> Void)?
        var isSubCompleted: Bool
    }
    
    private var persistantStorage: PersistantStorage
    
    @Published var navigateToDetails = false
    @Published var challengesVM: [ChallengeVM] = []
    @Published var selectedChallenge: Challenge?
    
    
    init(persistantStorage: PersistantStorage = PersistantStorage.shared) {
        self.persistantStorage = persistantStorage
    }
    
    private func getChallenges() {
        guard let category = self.persistantStorage.getCategories().filter({ $0.categoryId == "2" }).first else { return }
        
       
        let challenges = persistantStorage.getChallenges()
        let filteredChallenges = challenges.filter({ challenge in
            category.challengeIds.contains(challenge.wrappedChallengeId)
        }).prefix(5)
        
        challengesVM = filteredChallenges.map({ challenge in
            
            return ChallengeVM(
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
        self.getChallenges()
    }
    
}
