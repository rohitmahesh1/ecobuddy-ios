//
//  Challenge+CoreDataProperties.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 10/10/23.
//
//

import Foundation
import CoreData


extension Challenge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Challenge> {
        return NSFetchRequest<Challenge>(entityName: "Challenge")
    }

    @NSManaged public var challengeDescription: String
    @NSManaged public var challengeId: String
    @NSManaged public var challengeImage: URL?
    @NSManaged public var challengeTitle: String
    @NSManaged public var challengeVideoURL: String?
    @NSManaged public var displayOrder: Int16
    @NSManaged public var isCompleted: Bool
    @NSManaged public var subChallenges: [String]?
    
    public var wrappedChallengeId: String {
        challengeId
    }
    
    public var wrappedChallengeTitle: String {
        challengeTitle
    }
    
    public var wrappedChallengeDescription: String {
        challengeDescription
    }
    
    public var subChallengeIds: [String] {
        guard let subChallenges else { return [] }
        let orderedIds = NSOrderedSet(array: subChallenges).array.compactMap { $0 as? String }
        return orderedIds
    }

}

extension Challenge : Identifiable {

}
