//
//  UsersRepositoryProtocol.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 01/04/2026.
//

import Foundation

protocol UsersServiceProtocol {
    func getUsers(page: Int, results: Int) async throws -> [User]
}
