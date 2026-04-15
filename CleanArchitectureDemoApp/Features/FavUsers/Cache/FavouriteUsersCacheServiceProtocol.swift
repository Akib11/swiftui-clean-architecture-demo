//
//  FavouriteUsersCacheServiceProtocol.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 15/04/2026.
//

import Foundation

protocol FavouriteUsersCacheServiceProtocol {
    func save(user: User) throws
    func remove(userId: String) throws
    func fetchUsers() throws -> [User]
    func isFavourite(userId: String) throws -> Bool
}
