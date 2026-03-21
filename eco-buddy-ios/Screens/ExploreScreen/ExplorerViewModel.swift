//
//  ExplorerViewModel.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 11/10/23.
//

import Foundation


class ExplorerViewModel: ObservableObject {
    struct ChallengeVM: Identifiable {
        var id = UUID()
        var challenge: Challenge
        var isSubCompleted: Bool
        var onTap: (() -> Void)?
    }
 
    
    let persistantStorage: PersistantStorage
    var category: ChallengeCategory?
    
    var screenTitle: String {
        return category?.wrappedCategoryTitle ?? "Title"
    }
    
    @Published var navigateToDetails = false
    @Published var challengesVM: [ChallengeVM] = []
    @Published var selectedChallenge: Challenge?
    
    init(category: ChallengeCategory? = nil, persistantStorage: PersistantStorage = PersistantStorage.shared) {
        self.category = category
        self.persistantStorage = persistantStorage
    }
    
    func fetchChallenges() {
        let challenges = persistantStorage.getChallenges()
        
        self.challengesVM = challenges.map({ challenge in
            let subChallengeIds = challenge.subChallengeIds
            let subChallenges = persistantStorage.getSubChallenges().filter { subChallenge in
                subChallengeIds.contains(subChallenge.wrappedSubChallengeId)
            }
            let allDone = subChallenges.allSatisfy { $0.challengeStatus } && !subChallenges.isEmpty
            
            return ChallengeVM(
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
