//
//  MockUsersService.swift
//  CleanArchitectureDemoAppTests
//
//  Created by Akib Quraishi on 22/06/2026.
//

import Foundation
@testable import CleanArchitectureDemoApp

final class MockUsersService: UsersServiceProtocol {
    
    var usersToReturn: [User] = []
    var errorToThrow: Error?
    private(set) var getUsersCalled = false
    
    func getUsers(page: Int, results: Int) async throws -> [User] {
        getUsersCalled = true
        
        if let errorToThrow {
            throw errorToThrow
        }
        
        return usersToReturn
    }
}
