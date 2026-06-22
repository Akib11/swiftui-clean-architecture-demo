//
//  UsersViewModelTests.swift
//  CleanArchitectureDemoAppTests
//
//  Created by Akib Quraishi on 22/06/2026.
//

import Foundation
import XCTest
@testable import CleanArchitectureDemoApp

@MainActor
final class UsersViewModelTests: XCTestCase {
    
    func test_loadUsers_whenUseCaseSucceeds_setsSuccessState() async {
        let getUsersUseCase = MockGetUsersUseCase()
        
        let expectedUsers = [
            User(
                id: "1",
                fullName: "John Appleseed",
                email: "john@test.com",
                avatarURL: "avatar-url"
            )
        ]
        
        getUsersUseCase.usersToReturn = expectedUsers
        
        let sut = UsersViewModel(
            getUsersUseCase: getUsersUseCase,
            getFavouriteUsersUseCase: MockGetFavouriteUsersUseCase(),
            addFavouriteUserUseCase: MockAddFavouriteUserUseCase(),
            removeFavouriteUserUseCase: MockRemoveFavouriteUserUseCase()
        )
        
        await sut.loadUsers()
        
        switch sut.state {
        case .success(let users):
            XCTAssertEqual(users, expectedUsers)
        default:
            XCTFail("Expected success state")
        }
    }
    
    func test_loadUsers_whenUseCaseFails_setsFailureState() async {
        let getUsersUseCase = MockGetUsersUseCase()
        getUsersUseCase.errorToThrow = URLError(.notConnectedToInternet)
        
        let sut = UsersViewModel(
            getUsersUseCase: getUsersUseCase,
            getFavouriteUsersUseCase: MockGetFavouriteUsersUseCase(),
            addFavouriteUserUseCase: MockAddFavouriteUserUseCase(),
            removeFavouriteUserUseCase: MockRemoveFavouriteUserUseCase()
        )
        
        await sut.loadUsers()
        
        switch sut.state {
        case .failure(let message):
            XCTAssertFalse(message.isEmpty)
        default:
            XCTFail("Expected failure state")
        }
    }
}
