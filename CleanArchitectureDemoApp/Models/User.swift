//
//  User.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 01/04/2026.
//

import Foundation

struct User: Identifiable, Hashable {
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
