//
//  UsersRepositoryProtocol.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 01/04/2026.
//

import Foundation

protocol UsersRepositoryProtocol {
    func getUsers(page: Int, results: Int) async throws -> [User]
}
