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

    @NSManaged public var challengeId: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var challengeTitle: String?
    @NSManaged public var challengeDescription: String?
    @NSManaged public var challengeImage: URL?
    @NSManaged public var challengeVIdeoURL: String?
    @NSManaged public var subChallenges: [String]?
    
    public var wrappedChallengeId: String {
        challengeId ?? "unknown challenge id"
    }
    
    public var wrappedChallengeTitle: String {
        challengeTitle ?? "unknown challenge title"
    }
    
    public var wrappedChallengeDescription: String {
        challengeDescription ?? "unknown challenge description"
    }
    
    public var subChallengesIDs: [String] {
        guard let subChallenges else { return [] }
        let set = Set(subChallenges)
        return set.sorted {
            $0 < $1
        }
    }

}

extension Challenge : Identifiable {

}
