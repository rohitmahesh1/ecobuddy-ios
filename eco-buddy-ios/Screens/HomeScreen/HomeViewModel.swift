//
//  HomeViewModel.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 11/10/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    struct CardViewModel {
        let uid: UUID = UUID()
        var category: ChallengeCategory
        var onTap: (() -> ())?
    }
    
    let persistantStorage: PersistantStorage
    
    @AppStorage("userName") var userName: String = ""
    @AppStorage("profileImage") var profileImage: String = ""

    @Published var cardViewModel: [CardViewModel] = []
    @Published var navigateToDetail = false
    @Published var navigateToUserProfile = false
    @Published var selectedCategory: ChallengeCategory?
    
    init(persistantStorage: PersistantStorage = PersistantStorage.shared) {
        self.persistantStorage = persistantStorage
    }
    
    func loadCategories() {
        guard let module = self.loadModule() else { return }
        let categoryIds = module.categoryIdArray
        
        let filteredCategory = persistantStorage.getCategories().filter({ category in
            categoryIds.contains(category.wrappedCategoryId)
        }).sorted {
            $0.categoryId ?? "" < $1.categoryId ?? ""
        }
        
        self.cardViewModel = filteredCategory.map({ category in
            return CardViewModel(
                category: category,
                onTap: {
                    self.selectedCategory = category
                    self.navigateToDetail = true
                }
            )
        })
    }
    
    private func loadModule() -> Module? {
        persistantStorage.getAllModules().filter({ $0.moduleTitle == "Home" }).first
    }
    
    
}
