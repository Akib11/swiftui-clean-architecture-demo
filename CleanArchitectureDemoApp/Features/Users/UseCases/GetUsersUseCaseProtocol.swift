//
//  GetUsersUseCaseProtocol.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 21/06/2026.
//

import Foundation

protocol GetUsersUseCaseProtocol {
    func execute(
        page: Int,
        results: Int
    ) async throws -> [User]
}
