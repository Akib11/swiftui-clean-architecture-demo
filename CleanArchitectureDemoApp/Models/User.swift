//
//  User.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 01/04/2026.
//

import Foundation

struct User: Identifiable, Hashable, Equatable {
    let id: String
    let fullName: String
    let email: String
    let avatarURL: String
}

extension User {
    init(from dto: RandomUserDTO) {
        self.id = dto.email // ✅ stable ID
        self.fullName = "\(dto.name.first) \(dto.name.last)"
        self.email = dto.email
        self.avatarURL = dto.picture.medium
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
