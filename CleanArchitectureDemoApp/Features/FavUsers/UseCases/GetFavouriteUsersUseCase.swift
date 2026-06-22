//
//  GetFavouriteUsersUseCase.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 22/06/2026.
//

import Foundation

protocol GetFavouriteUsersUseCaseProtocol {
    func execute() throws -> [User]
}

final class GetFavouriteUsersUseCase: GetFavouriteUsersUseCaseProtocol {
    
    private let repository: FavouriteUsersRepositoryProtocol
    
    init(repository: FavouriteUsersRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws -> [User] {
        try repository.getFavouriteUsers()
    }
}
