//
//  CreateGradingUseCase.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 19/02/25.
//
import Foundation

struct LhpGradingUseCase {
    private let repository: LhpGradingRepository
    
    init(repository: LhpGradingRepository) {
        self.repository = repository
    }
    
    func getCreateGrading() -> [GradingLhpEntity] {
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
