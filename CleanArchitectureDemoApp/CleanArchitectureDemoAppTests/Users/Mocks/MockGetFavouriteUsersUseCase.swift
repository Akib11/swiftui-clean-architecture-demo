//
//  MockGetFavouriteUsersUseCase.swift
//  CleanArchitectureDemoAppTests
//
//  Created by Akib Quraishi on 22/06/2026.
//

import Foundation
@testable import CleanArchitectureDemoApp

final class MockGetFavouriteUsersUseCase: GetFavouriteUsersUseCaseProtocol {
    var usersToReturn: [User] = []
    
    func execute() throws -> [User] {
        usersToReturn
    }
}

final class MockAddFavouriteUserUseCase: AddFavouriteUserUseCaseProtocol {
    func execute(user: User) throws { }
}

final class MockRemoveFavouriteUserUseCase: RemoveFavouriteUserUseCaseProtocol {
    func execute(userId: String) throws { }
}
