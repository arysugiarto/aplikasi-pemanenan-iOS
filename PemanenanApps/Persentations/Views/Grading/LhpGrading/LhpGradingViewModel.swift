//
//  CreateGradingViewModel.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 19/02/25.
//

import Foundation
import Combine
import CoreData

class LhpGradingViewModel: ObservableObject {
    @Published var createGrading: [GradingLhpEntity] = []
    
    private let context = PersistenceController.shared.container.viewContext
    
    private let lhpGradingUseCase: LhpGradingUseCase
    
    init(lhpGradingUseCase: LhpGradingUseCase) {
        self.lhpGradingUseCase = lhpGradingUseCase
        loadCreateGrading()
    }
    
    func loadCreateGrading() {
        createGrading = lhpGradingUseCase.getCreateGrading()
    }
    
    func addCreateGrading(noGrading: String, noOrderSale: String, location: String, date: Date ,species: String) {
        lhpGradingUseCase.addCreateGrading(noGrading: noGrading, noOrderSale: noOrderSale, location: location, date: date,species: species)
        appendNewGrading(noGrading: noGrading, noOrderSale: noOrderSale, location: location, date: date, species: species)
    }
    
    func updateCreateGrading(id: UUID, noGrading: String, noOrderSale: String) {
        lhpGradingUseCase.updateCreateGrading(id: id, noGrading: noGrading, noOrderSale: noOrderSale)
        if let index = createGrading.firstIndex(where: { $0.id == id }) {
            createGrading[index].noGrading = noGrading
            createGrading[index].noOrderSale = noOrderSale
        }
    }
    
    func deleteCreateGrading(id: UUID) {
        let context = PersistenceController.shared.context
        let request: NSFetchRequest<GradingLhpEntity> = GradingLhpEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let results = try context.fetch(request)
            if let gradingToDelete = results.first {
                context.delete(gradingToDelete)
                try context.save()
            }
            // Perbarui daftar grading setelah penghapusan
            loadCreateGrading()
        } catch {
            print("❌ Gagal menghapus data: \(error.localizedDescription)")
        }
    }

    
    private func appendNewGrading(noGrading: String, noOrderSale: String, location: String, date: Date, species: String) {
        let context = PersistenceController.shared.context
        let newGrading = GradingLhpEntity(context: context)
        newGrading.id = UUID()
        newGrading.noGrading = noGrading
        newGrading.noOrderSale = noOrderSale
        newGrading.location = location
        newGrading.date = date
        newGrading.species = species

        do {
            try context.save() // Simpan ke Core Data
            createGrading.append(newGrading)
        } catch {
            print("❌ Gagal menyimpan data: \(error.localizedDescription)")
        }
    }
    
    //filter
    func fetchFilteredGradings(order: String?, species: String?, location: String?, date: Date?) {
        let request: NSFetchRequest<GradingLhpEntity> = GradingLhpEntity.fetchRequest()
        var predicates: [NSPredicate] = []

        if let order = order, order != "Pilih Pesanan" {
            predicates.append(NSPredicate(format: "noOrderSale == %@", order))
        }

        if let species = species, species != "Pilih Species" {
            predicates.append(NSPredicate(format: "species == %@", species))
        }

        if let location = location, location != "Pilih TPT Muat" {
            predicates.append(NSPredicate(format: "location == %@", location))
        }

        if let date = date {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: date)
            let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

            predicates.append(NSPredicate(format: "date >= %@ AND date < %@", startOfDay as NSDate, endOfDay as NSDate))
        }

        if !predicates.isEmpty {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }

        do {
            createGrading = try context.fetch(request)
        } catch {
            print("❌ Error fetching filtered gradings: \(error.localizedDescription)")
        }
    }
}
