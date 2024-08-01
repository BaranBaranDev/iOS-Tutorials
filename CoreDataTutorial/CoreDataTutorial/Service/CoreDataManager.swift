//
//  CoreDataManager.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 1.08.2024.
//

import Foundation
import CoreData


// MARK: CoreDataProtocol
protocol CoreDataProtocol {
    func save<T: NSManagedObject>(_ object: T)
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T]
}


// MARK: CoreDataManager Class
final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataTutorial")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - CoreDataProtocol Implement
extension CoreDataManager: CoreDataProtocol {
    
    // Generic save function
    func save<T: NSManagedObject>(_ object: T) {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    // Generic fetch function
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            return fetchedObjects
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
