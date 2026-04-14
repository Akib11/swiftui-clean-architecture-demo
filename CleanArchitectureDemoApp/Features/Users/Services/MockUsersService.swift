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
        
        return User.samples
    }
}


// MARK: - Sample Data

extension User {
    static let samples: [User] = [
        User(id: "1", fullName: "Alexandra Chen", email: "a.chen@studio.io", avatarURL: "https://i.pravatar.cc/150?img=1"),
        User(id: "2", fullName: "Marcus Rivera", email: "m.rivera@studio.io", avatarURL: "https://i.pravatar.cc/150?img=3"),
        User(id: "3", fullName: "Priya Nair", email: "p.nair@studio.io", avatarURL: "https://i.pravatar.cc/150?img=5"),
        User(id: "4", fullName: "Jordan Wells", email: "j.wells@studio.io", avatarURL: "https://i.pravatar.cc/150?img=7"),
        User(id: "5", fullName: "Sofia Andersen", email: "s.andersen@studio.io", avatarURL: "https://i.pravatar.cc/150?img=9"),
        User(id: "6", fullName: "Tobias Müller", email: "t.muller@studio.io", avatarURL: "https://i.pravatar.cc/150?img=11"),
    ]
}
