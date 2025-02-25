//
//  CreateGradingRepository.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 19/02/25.
//

import Foundation
import CoreData

protocol LhpGradingRepository {
    func getAllCreateGrading() -> [GradingLhpEntity]
    func addCreateGrading(noGrading: String, noOrderSale: String, location: String, date: Date, species: String)
    func updateCreateGrading(id: UUID, noGrading: String, noOrderSale: String)
    func deleteCreateGrading(id: UUID)
}
