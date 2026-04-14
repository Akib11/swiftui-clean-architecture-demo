//
//  UsersRepository.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 01/04/2026.
//

import Foundation

final class UsersService: UsersServiceProtocol {
    
    private let router: Router<UsersAPI>
    
    init(router: Router<UsersAPI>) {
        self.router = router
    }
    
    func getUsers(page: Int, results: Int = 20) async throws -> [User] {
        let response: RandomUserResponse = try await router.asyncRequest(
            endpoint: .users(page: page, results: results)
        )
        
        return response.results.map(User.init)
    }
}
