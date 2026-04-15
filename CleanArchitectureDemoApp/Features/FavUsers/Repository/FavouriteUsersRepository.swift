//
//  FavouriteUsersRepository.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 15/04/2026.
//

import Foundation

final class FavouriteUsersRepository: FavouriteUsersRepositoryProtocol {
    
    private let cacheService: FavouriteUsersCacheServiceProtocol
    
    init(cacheService: FavouriteUsersCacheServiceProtocol) {
        self.cacheService = cacheService
    }
    
    func getFavouriteUsers() throws -> [User] {
        try cacheService.fetchUsers()
    }
    
    func addToFavourites(user: User) throws {
        try cacheService.save(user: user)
    }
    
    func removeFromFavourites(userId: String) throws {
        try cacheService.remove(userId: userId)
    }
    
    func isFavourite(userId: String) throws -> Bool {
        try cacheService.isFavourite(userId: userId)
    }
}
