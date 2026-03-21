//
//  SubChallenge+CoreDataProperties.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 10/10/23.
//
//

import Foundation
import CoreData


extension SubChallenge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubChallenge> {
        return NSFetchRequest<SubChallenge>(entityName: "SubChallenge")
    }

    @NSManaged public var challengeStatus: Bool
    @NSManaged public var challengeTitle: String
    @NSManaged public var displayOrder: Int16
    @NSManaged public var subChallengeId: String
    
    public var wrappedSubChallengeId: String {
        subChallengeId
    }
    
    public var wrappedChallengeTitle: String {
        challengeTitle
    }
}

extension SubChallenge : Identifiable {

}
