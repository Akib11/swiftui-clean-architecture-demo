//
//  IsFavouriteUserUseCase.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 22/06/2026.
//

import Foundation

protocol IsFavouriteUserUseCaseProtocol {
    func execute(userId: String) throws -> Bool
}

final class IsFavouriteUserUseCase: IsFavouriteUserUseCaseProtocol {
    
    private let repository: FavouriteUsersRepositoryProtocol
    
    init(repository: FavouriteUsersRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(userId: String) throws -> Bool {
        try repository.isFavourite(userId: userId)
    }
}
