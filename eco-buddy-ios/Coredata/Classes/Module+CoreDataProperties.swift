//
//  Module+CoreDataProperties.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 10/10/23.
//
//

import Foundation
import CoreData


extension Module {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Module> {
        return NSFetchRequest<Module>(entityName: "Module")
    }

    @NSManaged public var moduleId: String?
    @NSManaged public var moduleTitle: String?
    @NSManaged public var categoryIds: [String]?
    
    public var wrappedModuleID: String {
        moduleId ?? "unknown module Id"
    }
    
    public var wrappedModuleTitle: String {
        moduleTitle ?? "unknown wrapped title"
    }
    
    public var categoryIdArray: [String] {
        guard let categoryIds else { return [] }
        let set = Set(categoryIds)
        return set.sorted {
            $0 < $1
        }
    }

}

extension Module : Identifiable {

}
