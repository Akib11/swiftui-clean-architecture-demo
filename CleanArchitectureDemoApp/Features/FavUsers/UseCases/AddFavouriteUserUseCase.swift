//
//  AddFavouriteUserUseCase.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 22/06/2026.
//

import Foundation

protocol AddFavouriteUserUseCaseProtocol {
    func execute(user: User) throws
}

final class AddFavouriteUserUseCase: AddFavouriteUserUseCaseProtocol {
    
    private let repository: FavouriteUsersRepositoryProtocol
    
    init(repository: FavouriteUsersRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(user: User) throws {
        try repository.addToFavourites(user: user)
    }
}
