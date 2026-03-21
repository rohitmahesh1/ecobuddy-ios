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

    @NSManaged public var challengeId: String?
    @NSManaged public var challengeTitle: String?
    @NSManaged public var challengeStatus: Bool
    
    public var wrappedChallengeId: String {
        challengeId ?? "unknown challenge id"
    }
    
    public var wrappedChallengeTitle: String {
        challengeTitle ?? "unknown challenge title"
    }
}

extension SubChallenge : Identifiable {

}
