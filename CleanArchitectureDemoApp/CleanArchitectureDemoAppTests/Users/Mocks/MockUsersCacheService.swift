//
//  MockUsersCacheService.swift
//  CleanArchitectureDemoAppTests
//
//  Created by Akib Quraishi on 22/06/2026.
//

import Foundation
@testable import CleanArchitectureDemoApp

final class MockUsersCacheService: UsersCacheServiceProtocol {
    
    var storedUsers: [User] = []
    private(set) var saveCalled = false
    private(set) var fetchCalled = false
    private(set) var clearCalled = false
    
    func save(users: [User]) throws {
        saveCalled = true
        storedUsers.append(contentsOf: users)
    }
    
    func fetchUsers() throws -> [User] {
        fetchCalled = true
        return storedUsers
    }
    
    func clearUsers() throws {
        clearCalled = true
        storedUsers.removeAll()
    }
}
