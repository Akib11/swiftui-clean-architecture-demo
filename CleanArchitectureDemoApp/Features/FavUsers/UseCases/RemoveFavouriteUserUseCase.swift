//
//  RemoveFavouriteUserUseCase.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 22/06/2026.
//

import Foundation

protocol RemoveFavouriteUserUseCaseProtocol {
    func execute(userId: String) throws
}

final class RemoveFavouriteUserUseCase: RemoveFavouriteUserUseCaseProtocol {
    
    private let repository: FavouriteUsersRepositoryProtocol
    
    init(repository: FavouriteUsersRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(userId: String) throws {
        try repository.removeFromFavourites(userId: userId)
    }
}
