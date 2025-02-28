//
//  AssigmentViewModel.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 28/02/25.
//

import Foundation

class NewAssignmentViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var assignments: [NewAssignmentResponse.AssignmentData] = []
    @Published var errorMessage: String?

    private let fetchNewAssignmentUseCase: FetchNewAssignmentUseCase

    init(fetchNewAssignmentUseCase: FetchNewAssignmentUseCase = FetchNewAssignmentUseCase()) {
        self.fetchNewAssignmentUseCase = fetchNewAssignmentUseCase
    }

    func loadNewAssignment() {
        isLoading = true
        fetchNewAssignmentUseCase.execute(userAccessID: 682) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let data):
                    self?.assignments = data
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
