//
//  UsersCacheServiceProtocol.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 14/04/2026.
//

import Foundation

protocol UsersCacheServiceProtocol {
    func save(users: [User]) throws
    func fetchUsers() throws -> [User]
    func clearUsers() throws
}
