//
//  NewAssigmentResponse.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 28/02/25.
//

import Foundation

struct NewAssignmentResponse: Codable {
    let success: Bool
    let message: String
    let data: [AssignmentData]?

    struct AssignmentData: Codable, Identifiable {
        let id: Int
        let orderName: String
        let location: String
    }
}
