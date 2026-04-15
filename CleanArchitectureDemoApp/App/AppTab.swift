//
//  AppTab.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 15/03/2026.
//

import Foundation

enum AppTab: Hashable {
    case users
    case favouriteUsers
    
    var title: String {
        switch self {
        case .users:
            return "Users"
        case .favouriteUsers:
            return "Fav Users"
        }
    }
    
    var systemImage: String {
        switch self {
        case .users:
            return "person.3"
        case .favouriteUsers:
            return "heart.fill"
        }
    }
}
