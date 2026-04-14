//
//  DependencyContainer.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 10/03/2026.
//

import Foundation
import SwiftData

final class DependencyContainer {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func makeUsersService() -> UsersServiceProtocol {
        UsersService(router: Router<UsersAPI>())
    }
    
    func makeUsersCacheService() -> UsersCacheServiceProtocol {
        UsersCacheService(modelContext: modelContext)
    }
    
    func makeUsersRepository() -> UsersRepositoryProtocol {
        UsersRepository(
            remoteService: makeUsersService(),
            cacheService: makeUsersCacheService()
        )
    }
    
    func makeUsersViewModel() -> UsersViewModel {
        UsersViewModel(repository: makeUsersRepository())
    }
}
