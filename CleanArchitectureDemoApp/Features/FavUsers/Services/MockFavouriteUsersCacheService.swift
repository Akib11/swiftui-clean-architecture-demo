//
//  MockFavouriteUsersCacheService.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 15/04/2026.
//

import Foundation

final class MockFavouriteUsersCacheService: FavouriteUsersCacheServiceProtocol {
    
    private var storedUsers: [User] = []
    
    func save(user: User) throws {
        guard !storedUsers.contains(where: { $0.id == user.id }) else { return }
        storedUsers.append(user)
    }
    
    func remove(userId: String) throws {
        storedUsers.removeAll { $0.id == userId }
    }
    
    func fetchUsers() throws -> [User] {
        storedUsers
    }
    
    func isFavourite(userId: String) throws -> Bool {
        storedUsers.contains { $0.id == userId }
    }
}
