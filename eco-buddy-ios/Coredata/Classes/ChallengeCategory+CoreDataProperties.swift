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

    @NSManaged public var categoryId: String?
    @NSManaged public var categoryTitle: String?
    @NSManaged public var categoryDescription: String?
    @NSManaged public var challengesIds: [String]?
    
    public var wrappedCategoryId: String {
        categoryId ?? "unknown category id"
    }
    
    public var wrappedCategoryTitle: String {
        categoryTitle ?? "unknown category title"
    }
    
    public var wrappedCategoryDescription: String {
        categoryDescription ?? "unknown description"
    }
    
    public var challengeIdArray: [String] {
        guard let challengesIds else { return [] }
        let set = Set(challengesIds)
        return set.sorted {
            $0 < $1
        }
    }
    

}

extension ChallengeCategory : Identifiable {

}
