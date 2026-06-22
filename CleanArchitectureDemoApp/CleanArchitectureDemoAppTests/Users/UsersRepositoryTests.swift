//
//  UsersRepositoryTests.swift
//  CleanArchitectureDemoAppTests
//
//  Created by Akib Quraishi on 22/06/2026.
//

import Foundation
import XCTest
@testable import CleanArchitectureDemoApp

final class UsersRepositoryTests: XCTestCase {
    
    func test_getUsers_whenRemoteSucceeds_returnsRemoteUsersAndCachesThem() async throws {
        let remoteService = MockUsersService()
        let cacheService = MockUsersCacheService()
        
        let expectedUsers = [
            User(
                id: "1",
                fullName: "John Appleseed",
                email: "john@test.com",
                avatarURL: "avatar-url"
            )
        ]
        
        remoteService.usersToReturn = expectedUsers
        
        let sut = await UsersRepository(
            remoteService: remoteService,
            cacheService: cacheService
        )
        
        let result = try await sut.getUsers(page: 1, results: 20)
        
        XCTAssertEqual(result, expectedUsers)
        XCTAssertTrue(remoteService.getUsersCalled)
        XCTAssertTrue(cacheService.saveCalled)
        XCTAssertEqual(cacheService.storedUsers, expectedUsers)
    }
    
    func test_getUsers_whenRemoteFails_returnsCachedUsers() async throws {
        let remoteService = MockUsersService()
        let cacheService = MockUsersCacheService()
        
        let cachedUsers = [
            User(
                id: "1",
                fullName: "Cached User",
                email: "cached@test.com",
                avatarURL: "cached-avatar"
            )
        ]
        
        remoteService.errorToThrow = URLError(.notConnectedToInternet)
        cacheService.storedUsers = cachedUsers
        
        let sut = await UsersRepository(
            remoteService: remoteService,
            cacheService: cacheService
        )
        
        let result = try await sut.getUsers(page: 1, results: 20)
        
        XCTAssertEqual(result, cachedUsers)
        XCTAssertTrue(remoteService.getUsersCalled)
        XCTAssertTrue(cacheService.fetchCalled)
    }
}
