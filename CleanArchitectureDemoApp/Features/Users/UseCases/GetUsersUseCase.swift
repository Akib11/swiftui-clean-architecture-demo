//
//  GetUsersUseCase.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 21/06/2026.
//

import Foundation

final class GetUsersUseCase: GetUsersUseCaseProtocol {
    
    private let repository: UsersRepositoryProtocol
    
    init(repository: UsersRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(
        page: Int,
        results: Int
    ) async throws -> [User] {
        try await repository.getUsers(
            page: page,
            results: results
        )
    }
}
