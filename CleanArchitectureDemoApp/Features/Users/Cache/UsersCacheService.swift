//
//  UsersCacheService.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 14/04/2026.
//

import Foundation
import SwiftData

final class UsersCacheService: UsersCacheServiceProtocol {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func save(users: [User]) throws {
        for user in users {
            let cachedUser = CachedUser(
                id: user.id,
                fullName: user.fullName,
                email: user.email,
                avatarURL: user.avatarURL
            )
            modelContext.insert(cachedUser)
        }
        
        try modelContext.save()
    }
    
    func fetchUsers() throws -> [User] {
        let descriptor = FetchDescriptor<CachedUser>()
        let cachedUsers = try modelContext.fetch(descriptor)
        
        return cachedUsers.map {
            User(
                id: $0.id,
                fullName: $0.fullName,
                email: $0.email,
                avatarURL: $0.avatarURL
            )
        }
    }
    
    func clearUsers() throws {
        let descriptor = FetchDescriptor<CachedUser>()
        let cachedUsers = try modelContext.fetch(descriptor)
        
        for user in cachedUsers {
            modelContext.delete(user)
        }
        
        try modelContext.save()
    }
}
