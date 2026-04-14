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


// MARK: - Sample Data

extension User {
    static let samples: [User] = [
        User(fullName: "Alexandra Chen", email: "a.chen@studio.io", avatarURL: "https://i.pravatar.cc/150?img=1"),
        User(fullName: "Marcus Rivera", email: "m.rivera@studio.io", avatarURL: "https://i.pravatar.cc/150?img=3"),
        User(fullName: "Priya Nair", email: "p.nair@studio.io", avatarURL: "https://i.pravatar.cc/150?img=5"),
        User(fullName: "Jordan Wells", email: "j.wells@studio.io", avatarURL: "https://i.pravatar.cc/150?img=7"),
        User(fullName: "Sofia Andersen", email: "s.andersen@studio.io", avatarURL: "https://i.pravatar.cc/150?img=9"),
        User(fullName: "Tobias Müller", email: "t.muller@studio.io", avatarURL: "https://i.pravatar.cc/150?img=11"),
    ]
}
