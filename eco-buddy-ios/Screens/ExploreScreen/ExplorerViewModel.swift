//
//  ExplorerViewModel.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 11/10/23.
//

import Foundation


class ExplorerViewModel: ObservableObject {
    struct ChallengeVM: Identifiable {
        let id: String
        var challenge: Challenge
        var isSubCompleted: Bool
        var onTap: (() -> Void)?
    }
 
    
    let persistentStorage: PersistentStorage
    var category: ChallengeCategory?
    
    var screenTitle: String {
        return category?.wrappedCategoryTitle ?? "Title"
    }
    
    @Published var navigateToDetails = false
    @Published var challengesVM: [ChallengeVM] = []
    @Published var selectedChallenge: Challenge?
    
    init(category: ChallengeCategory? = nil, persistentStorage: PersistentStorage = PersistentStorage.shared) {
        self.category = category
        self.persistentStorage = persistentStorage
    }
    
    func fetchChallenges() {
        let challenges = persistentStorage.getChallenges()
        self.selectedChallenge = nil
        
        self.challengesVM = challenges.map({ challenge in
            let subChallengeIds = challenge.subChallengeIds
            let subChallenges = persistentStorage.getSubChallenges().filter { subChallenge in
                subChallengeIds.contains(subChallenge.wrappedSubChallengeId)
            }
            let allDone = subChallenges.allSatisfy { $0.challengeStatus } && !subChallenges.isEmpty
            
            return ChallengeVM(
                id: challenge.wrappedChallengeId,
                challenge: challenge,
                isSubCompleted: allDone,
                onTap: {
                    self.selectedChallenge = challenge
                    self.navigateToDetails = true
                }
            )
        })
        
    }
    
    func onAppear() {
        self.fetchChallenges()
    }
}
