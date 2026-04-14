//
//  UsersServiceProtocol.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 14/04/2026.
//

import Foundation

protocol UsersServiceProtocol {
    func getUsers(page: Int, results: Int) async throws -> [User]
}
