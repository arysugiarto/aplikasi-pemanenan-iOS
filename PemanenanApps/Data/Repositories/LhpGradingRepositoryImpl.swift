//
//  CreateGradingRepository.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 19/02/25.
//

import Foundation
import CoreData

class LhpGradingRepositoryImpl: LhpGradingRepository {
    
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func getAllCreateGrading() -> [GradingLhpEntity] {
        let request: NSFetchRequest<GradingLhpEntity> = GradingLhpEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }
    
    func addCreateGrading(noGrading: String, noOrderSale: String, location: String, date: Date, species: String) {
        let newData = GradingLhpEntity(context: context)
        newData.id = UUID()
        newData.noGrading = noGrading
        newData.noOrderSale = noOrderSale
        newData.location = location
        newData.date = date
        newData.species = species
        saveContext()
    }

    func updateCreateGrading(id: UUID, noGrading: String, noOrderSale: String) {
        let request: NSFetchRequest<GradingLhpEntity> = GradingLhpEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let results = try context.fetch(request)
            if let gradingToUpdate = results.first {
                gradingToUpdate.noGrading = noGrading
                gradingToUpdate.noOrderSale = noOrderSale
                saveContext()
            }
        } catch {
            print("Error updating data: \(error)")
        }
    }

    func deleteCreateGrading(id: UUID) {
        let request: NSFetchRequest<GradingLhpEntity> = GradingLhpEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let results = try context.fetch(request)
            if let gradingToDelete = results.first {
                context.delete(gradingToDelete)
                saveContext()
            }
        } catch {
            print("Error deleting data: \(error)")
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }
}
