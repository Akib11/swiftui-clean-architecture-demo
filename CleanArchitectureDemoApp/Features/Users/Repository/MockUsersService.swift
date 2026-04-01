//
//  MockUsersService.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 01/04/2026.
//

import Foundation

final class MockUsersService: UsersServiceProtocol {
    
    var shouldFail = false
    
    func getUsers(page: Int, results: Int) async throws -> [User] {
        
        try await Task.sleep(nanoseconds: 800_000_000)
        
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        
        return (0..<results).map { index in
            User(
                fullName: "Mock User \(index)",
                email: "mock\(index)@test.com",
                avatarURL: "https://randomuser.me/api/portraits/women/\(index % 100).jpg"
            )
        }
    }
}
