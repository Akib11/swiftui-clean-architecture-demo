//
//  FavouriteUser.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 15/04/2026.
//

import Foundation
import SwiftData

@Model
final class FavouriteUser {
    var id: String
    var fullName: String
    var email: String
    var avatarURL: String
    
    init(
        id: String,
        fullName: String,
        email: String,
        avatarURL: String
    ) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.avatarURL = avatarURL
    }
}
