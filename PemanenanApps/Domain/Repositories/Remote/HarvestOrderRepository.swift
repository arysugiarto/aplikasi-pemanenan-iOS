//
//  HarvestOrderRepository 2.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 03/03/25.
//


import Foundation

protocol HarvestOrderRepository {
    func getNewAssignment(userAccessId: String, completion: @escaping (Result<[HarvestOrder], Error>) -> Void)
}
