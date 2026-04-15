//
//  FavouriteUsersCacheService.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 15/04/2026.
//

import Foundation
import SwiftData

final class FavouriteUsersCacheService: FavouriteUsersCacheServiceProtocol {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func save(user: User) throws {
        guard try !isFavourite(userId: user.id) else { return }
        
        let favourite = FavouriteUser(
            id: user.id,
            fullName: user.fullName,
            email: user.email,
            avatarURL: user.avatarURL
        )
        
        modelContext.insert(favourite)
        try modelContext.save()
    }
    
    func remove(userId: String) throws {
        let descriptor = FetchDescriptor<FavouriteUser>()
        let favourites = try modelContext.fetch(descriptor)
        
        if let favourite = favourites.first(where: { $0.id == userId }) {
            modelContext.delete(favourite)
            try modelContext.save()
        }
    }
    
    func fetchUsers() throws -> [User] {
        let descriptor = FetchDescriptor<FavouriteUser>()
        let favourites = try modelContext.fetch(descriptor)
        
        return favourites.map {
            User(
                id: $0.id,
                fullName: $0.fullName,
                email: $0.email,
                avatarURL: $0.avatarURL
            )
        }
    }
    
    func isFavourite(userId: String) throws -> Bool {
        let descriptor = FetchDescriptor<FavouriteUser>()
        let favourites = try modelContext.fetch(descriptor)
        return favourites.contains { $0.id == userId }
    }
}
