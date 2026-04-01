//
//  DependencyContainer.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 10/03/2026.
//

import Foundation

final class DependencyContainer {
    
    func makeUsersService() -> UsersServiceProtocol {
        UsersService(router: Router<UsersAPI>())
    }
    
    func makeUsersViewModel() -> UsersViewModel {
        UsersViewModel(service: makeUsersService())
    }
}
