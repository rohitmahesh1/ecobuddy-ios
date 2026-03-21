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
    
    typealias completionHandler = (Error?) -> Void
    
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
    
    
    func loadAllData(completion: @escaping completionHandler) {
        self.loadModules { error in
            guard error == nil else { return completion(error) }
            self.loadCategories { error in
                guard error == nil else { return completion(error) }
                self.loadChallenges { error in
                    guard error == nil else { return completion(error) }
                    self.loadSubChallenges(completion: completion)
                }
            }
        }
    }
    
    private func loadModules(_ completion: @escaping completionHandler) {
        var modulesById = self.getAllModules().reduce(into: [String: Module]()) { partialResult, module in
            partialResult[module.wrappedModuleId] = module
        }

        for moduleLocal in ModuleData.modules {
            let module = modulesById[moduleLocal.id] ?? Module(context: context)
            modulesById[moduleLocal.id] = module
            module.moduleId = moduleLocal.id
            module.moduleTitle = moduleLocal.title
            module.categoryIds = moduleLocal.categoryIds
            module.displayOrder = moduleLocal.displayOrder
        }

        self.saveContext(completion)
    }
    
    private func loadCategories(_ completion: @escaping completionHandler) {
        var categoriesById = self.getCategories().reduce(into: [String: ChallengeCategory]()) { partialResult, category in
            partialResult[category.wrappedCategoryId] = category
        }

        for categoryLocal in ChallengeCategoryData.categories {
            let category = categoriesById[categoryLocal.id] ?? ChallengeCategory(context: self.context)
            categoriesById[categoryLocal.id] = category
            category.categoryId = categoryLocal.id
            category.categoryTitle = categoryLocal.categoryTitle
            category.categoryDescription = categoryLocal.categoryDescription
            category.challengesIds = categoryLocal.challengeIds
            category.displayOrder = categoryLocal.displayOrder
        }

        self.saveContext(completion)
    }
    
    private func loadChallenges(_ completion: @escaping completionHandler) {
        var challengesById = self.getChallenges().reduce(into: [String: Challenge]()) { partialResult, challenge in
            partialResult[challenge.wrappedChallengeId] = challenge
        }

        for challengeLocal in ChallengesData.challenges {
            let challenge = challengesById[challengeLocal.id] ?? Challenge(context: self.context)
            let isNewChallenge = challengesById[challengeLocal.id] == nil
            challengesById[challengeLocal.id] = challenge
            challenge.challengeId = challengeLocal.id
            challenge.challengeTitle = challengeLocal.challengeTitle
            challenge.challengeDescription = challengeLocal.challengeDescription
            challenge.challengeImage = challengeLocal.challengeImage?.convertUrl
            challenge.challengeVideoURL = challengeLocal.videoURL
            challenge.displayOrder = challengeLocal.displayOrder
            challenge.subChallenges = challengeLocal.subChallengeIds
            if isNewChallenge {
                challenge.isCompleted = challengeLocal.isCompleted
            }
        }

        self.saveContext(completion)
    }
    
    private func loadSubChallenges(_ completion: @escaping completionHandler) {
        var subChallengesById = self.getSubChallenges().reduce(into: [String: SubChallenge]()) { partialResult, subChallenge in
            partialResult[subChallenge.wrappedSubChallengeId] = subChallenge
        }

        for subChallengeData in SubChallengesData.subChallenges {
            let subTask = subChallengesById[subChallengeData.id] ?? SubChallenge(context: self.context)
            let isNewSubChallenge = subChallengesById[subChallengeData.id] == nil
            subChallengesById[subChallengeData.id] = subTask
            subTask.subChallengeId = subChallengeData.id
            subTask.challengeTitle = subChallengeData.title
            subTask.displayOrder = subChallengeData.displayOrder
            if isNewSubChallenge {
                subTask.challengeStatus = subChallengeData.status
            }
        }

        self.saveContext(completion)
    }
    
}


extension PersistantStorage {
    private func saveContext(_ completion: @escaping completionHandler) {
        do {
            if self.context.hasChanges {
                try self.context.save()
            }

            DispatchQueue.main.async {
                completion(nil)
            }
        } catch {
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }

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
        fetchRequest.fetchLimit = 1
        
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
        fetchRequest.fetchLimit = 1
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
