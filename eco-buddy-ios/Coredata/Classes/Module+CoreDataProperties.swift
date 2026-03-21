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

    @NSManaged public var categoryIds: [String]?
    @NSManaged public var displayOrder: Int16
    @NSManaged public var moduleId: String
    @NSManaged public var moduleTitle: String
    
    public var wrappedModuleId: String {
        moduleId
    }
    
    public var wrappedModuleTitle: String {
        moduleTitle
    }
    
    public var categoryIdsArray: [String] {
        guard let categoryIds else { return [] }
        let orderedIds = NSOrderedSet(array: categoryIds).array.compactMap { $0 as? String }
        return orderedIds
    }

}

extension Module : Identifiable {

}
