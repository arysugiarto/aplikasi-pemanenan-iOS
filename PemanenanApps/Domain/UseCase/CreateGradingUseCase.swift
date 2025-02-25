//
//  CreateGradingUseCase.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 19/02/25.
//
import Foundation

struct CreateGradingUseCase {
    private let repository: CreateGradingRepository
    
    init(repository: CreateGradingRepository) {
        self.repository = repository
    }
    
    func getCreateGrading() -> [GradingCreateEntity] {
        return repository.getAllCreateGrading()
    }
    
    func addCreateGrading(noGrading: String, noOrderSale: String, location: String, date: Date, species: String) {
        repository.addCreateGrading(noGrading: noGrading, noOrderSale: noOrderSale, location: location, date: date, species: species)
    }

    func updateCreateGrading(id: UUID, noGrading: String, noOrderSale: String) {
        repository.updateCreateGrading(id: id, noGrading: noGrading, noOrderSale: noOrderSale)
    }

    func deleteCreateGrading(id: UUID) {
        repository.deleteCreateGrading(id: id)
    }
}
