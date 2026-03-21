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
    
    let persistentStorage: PersistentStorage
    
    @AppStorage("userName") var userName: String = ""
    @AppStorage("profileImage") var profileImage: String = ""

    @Published var cardViewModel: [CardViewModel] = []
    @Published var navigateToDetail = false
    @Published var navigateToUserProfile = false
    @Published var selectedCategory: ChallengeCategory?
    
    init(persistentStorage: PersistentStorage = PersistentStorage.shared) {
        self.persistentStorage = persistentStorage
    }
    
    func loadCategories() {
        guard let module = self.loadModule() else { return }
        let categoryIds = module.categoryIdsArray
        let categoryOrder = Dictionary(uniqueKeysWithValues: categoryIds.enumerated().map { ($1, $0) })
        
        let filteredCategory = persistentStorage.getCategories().filter({ category in
            categoryIds.contains(category.wrappedCategoryId)
        }).sorted {
            let leftOrder = categoryOrder[$0.wrappedCategoryId] ?? .max
            let rightOrder = categoryOrder[$1.wrappedCategoryId] ?? .max
            return leftOrder < rightOrder
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
        persistentStorage.getAllModules().first
    }
    
    
}
