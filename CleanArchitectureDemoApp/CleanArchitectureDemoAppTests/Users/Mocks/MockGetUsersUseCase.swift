//
//  MockGetUsersUseCase.swift
//  CleanArchitectureDemoAppTests
//
//  Created by Akib Quraishi on 22/06/2026.
//

import Foundation
@testable import CleanArchitectureDemoApp

final class MockGetUsersUseCase: GetUsersUseCaseProtocol {
    
    var usersToReturn: [User] = []
    var errorToThrow: Error?
    
    func execute(page: Int, results: Int) async throws -> [User] {
        if let errorToThrow {
            throw errorToThrow
        }
        
        return usersToReturn
    }
}
