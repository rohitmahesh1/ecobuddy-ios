//
//  PersistantStorage.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 10/10/23.
//

import Foundation
import CoreData


class PersistantStorage {
    static let shared = PersistantStorage()
    
    let container: NSPersistentContainer
    
    typealias completionHandler = (((Error?) -> ()))
    
    var context: NSManagedObjectContext {
        return self.container.viewContext
    }
    
    init() {
        container = NSPersistentContainer(name: "DataModel")
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        container.loadPersistentStores{ (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolve Error: \(error)")
            }
        }
    }
    
    func getSQLiteFileURL() -> URL? {
        let fileManager = FileManager.default
        if let documentsDirectory = fileManager.urls(for: .libraryDirectory, in: .userDomainMask).first {
            let sqliteFileName = "DataModel.sqlite"
            let sqliteFileURL = documentsDirectory.appendingPathComponent(sqliteFileName)
            return sqliteFileURL
        }
        return nil
    }
    
    
    func loadAllData(completion: @escaping (() -> Void)) {
        self.loadModules { error in
            if let _ = error { print( "Error saving modules" ) } else {
                self.loadCategories { error in
                    if let  _ = error { print("Error saving categories" )} else {
                        self.loadChallenges { error in
                            if let  _ = error { print("Error saving challenges")} else {
                                self.loadSubChallenges { error in
                                    if let  _ = error { print("Error loading subchallenges")} else {
                                        completion()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func loadModules(_ completion: @escaping completionHandler) {
        
        for moduleLocal in ModuleData.modules {
            let module = Module(context: context)
            module.moduleId = moduleLocal.id
            module.moduleTitle = moduleLocal.title
            module.categoryIds = moduleLocal.categoryIds
            module.displayOrder = moduleLocal.displayOrder
        }
        
        do {
            try self.context.save()
        } catch {
            print(error.localizedDescription)
            DispatchQueue.main.async {
                completion(error)
            }
        }
        
        DispatchQueue.main.async {
            print("✅Modules loaded in DB")
            completion(nil)
        }
        
    }
    
    private func loadCategories(_ completion: @escaping completionHandler) {
        
        for categoryLocal in ChallengeCategoryData.categories {
            let category = ChallengeCategory(context: self.context)
            category.categoryId = categoryLocal.id
            category.categoryTitle = categoryLocal.categoryTitle
            category.categoryDescription = categoryLocal.categoryDescription
            category.challengesIds = categoryLocal.challengeIds
            category.displayOrder = categoryLocal.displayOrder
        }
        
        do {
            try self.context.save()
        } catch {
            print(error.localizedDescription)
            DispatchQueue.main.async {
                completion(error)
            }
        }
        
        DispatchQueue.main.async {
            print("✅Challenges loaded in DB")
            completion(nil)
        }
        
    }
    
    private func loadChallenges(_ completion: @escaping completionHandler) {
        
        for challengeLocal in ChallengesData.challenges {
            let challenge = Challenge(context: self.context)
            challenge.challengeId = challengeLocal.id
            challenge.challengeTitle = challengeLocal.challengeTitle
            challenge.challengeDescription = challengeLocal.challengeDescription
            challenge.challengeImage =  challengeLocal.challengeImage?.convertUrl
            challenge.challengeVideoURL = challengeLocal.videoURL
            challenge.displayOrder = challengeLocal.displayOrder
            challenge.isCompleted = challengeLocal.isCompleted
            if let challengeSubIds = challengeLocal.subChallengeIds {
                challenge.subChallenges = challengeSubIds
            }
            
            
            do {
                try self.context.save()
            } catch {
                DispatchQueue.main.async {
                    completion(error)
                    print(error.localizedDescription)
                }
            }
        }
        
        DispatchQueue.main.async {
            print("✅Challenges loaded in DB")
            completion(nil)
        }
        
    }
    
    private func loadSubChallenges(_ completion: @escaping completionHandler) {
        
        for subChallengeData in SubChallengesData.subChallenges {
            let subTask = SubChallenge(context: self.context)
            subTask.subChallengeId = subChallengeData.id
            subTask.challengeTitle = subChallengeData.title
            subTask.challengeStatus = subChallengeData.status
            subTask.displayOrder = subChallengeData.displayOrder
            
            do {
                try self.context.save()
            } catch {
                DispatchQueue.main.async {
                    completion(error)
                    print(error.localizedDescription)
                }
            }
        }
        
        DispatchQueue.main.async {
            completion(nil)
            print("✅Sub challenges loaded in DB")
        }
    }
    
}


extension PersistantStorage {

    func getAllModules() -> [Module] {
        let request = Module.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "displayOrder", ascending: true)]
        do {
            let list = try container.viewContext.fetch(request)
            return list
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getCategories() -> [ChallengeCategory] {
        let request = ChallengeCategory.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "displayOrder", ascending: true)]
        do {
            let list = try container.viewContext.fetch(request)
            return list
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getChallenges() -> [Challenge] {
        let request = Challenge.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "displayOrder", ascending: true)]
        do {
            let list = try container.viewContext.fetch(request)
            return list
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getSubChallenges() -> [SubChallenge] {
        let request = SubChallenge.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "displayOrder", ascending: true)]
        do {
            let list = try container.viewContext.fetch(request)
            return list
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func editSubTask(_ subChallenge: SubChallenge, isDone: Bool, completion: (() -> ())) {
        let fetchRequest = SubChallenge.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "subChallengeId == %@", subChallenge.wrappedSubChallengeId)
        
        do {
            guard let challengeToEdit = try container.viewContext.fetch(fetchRequest).first else { return }
            challengeToEdit.challengeStatus = !isDone
            try container.viewContext.save()
            completion()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func editChallenge(_ challenge: Challenge, isDone: Bool, completion: (() -> ())) {
        let fetchRequest = Challenge.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "challengeId == %@", challenge.wrappedChallengeId)
        do {
            guard let challengeToEdit = try container.viewContext.fetch(fetchRequest).first else { return }
            challengeToEdit.isCompleted = isDone
            try container.viewContext.save()
            completion()
        } catch {
            print(error.localizedDescription)
        }
    }
}
