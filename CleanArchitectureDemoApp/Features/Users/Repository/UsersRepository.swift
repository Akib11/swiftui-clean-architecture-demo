//
//  UsersRepository.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 14/04/2026.
//

import Foundation

final class UsersRepository: UsersRepositoryProtocol {
    
    private let remoteService: UsersServiceProtocol
    private let cacheService: UsersCacheServiceProtocol
    
    init(
        remoteService: UsersServiceProtocol,
        cacheService: UsersCacheServiceProtocol
    ) {
        self.remoteService = remoteService
        self.cacheService = cacheService
    }
    
    func getUsers(page: Int, results: Int) async throws -> [User] {
        do {
            let users = try await remoteService.getUsers(page: page, results: results)
            
            if page == 1 {
                try? cacheService.clearUsers()
            }
            
            try? cacheService.save(users: users)
            return users
            
        } catch {
            let cachedUsers = try cacheService.fetchUsers()
            
            if !cachedUsers.isEmpty {
                return cachedUsers
            }
            
            throw error
        }
    }
}
