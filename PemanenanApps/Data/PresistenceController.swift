//
//  PresistenceController.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 20/02/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    var context: NSManagedObjectContext {
        return container.viewContext
    }

    init() {
        container = NSPersistentContainer(name: "PemanenanDatabase") // Sesuaikan dengan nama database
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Error loading Core Data: \(error)")
            }
        }
    }

    func saveContext() {
        let context = container.viewContext
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
