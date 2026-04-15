//
//  FavouriteUsersRepositoryProtocol.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 15/04/2026.
//

import Foundation

protocol FavouriteUsersRepositoryProtocol {
    func getFavouriteUsers() throws -> [User]
    func addToFavourites(user: User) throws
    func removeFromFavourites(userId: String) throws
    func isFavourite(userId: String) throws -> Bool
}
