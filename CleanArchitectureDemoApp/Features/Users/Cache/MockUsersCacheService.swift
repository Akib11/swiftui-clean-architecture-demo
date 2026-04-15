//
//  MockUsersCacheService.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 14/04/2026.
//

import Foundation

final class MockUsersCacheService: UsersCacheServiceProtocol {
    
    private var storedUsers: [User] = []
    
    func save(users: [User]) throws {
        storedUsers.append(contentsOf: users)
    }
    
    func fetchUsers() throws -> [User] {
        storedUsers
    }
    
    func clearUsers() throws {
        storedUsers.removeAll()
    }
}
