//
//  ChallengeCategory+CoreDataProperties.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 10/10/23.
//
//

import Foundation
import CoreData


extension ChallengeCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChallengeCategory> {
        return NSFetchRequest<ChallengeCategory>(entityName: "ChallengeCategory")
    }

    @NSManaged public var categoryDescription: String
    @NSManaged public var categoryId: String
    @NSManaged public var categoryTitle: String
    @NSManaged public var challengesIds: [String]?
    @NSManaged public var displayOrder: Int16
    
    public var wrappedCategoryId: String {
        categoryId
    }
    
    public var wrappedCategoryTitle: String {
        categoryTitle
    }
    
    public var wrappedCategoryDescription: String {
        categoryDescription
    }
    
    public var challengeIds: [String] {
        guard let challengesIds else { return [] }
        let orderedIds = NSOrderedSet(array: challengesIds).array.compactMap { $0 as? String }
        return orderedIds
    }
    

}

extension ChallengeCategory : Identifiable {

}
