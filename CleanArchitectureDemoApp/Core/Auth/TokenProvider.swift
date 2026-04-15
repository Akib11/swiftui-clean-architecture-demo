//
//  TokenProvider.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 15/03/2026.
//

import Foundation
import Combine

protocol TokenProvider {
    func accessToken() -> String?
}

final class DefaultTokenProvider: TokenProvider {

    private let sessionStore: SessionStore

    init(sessionStore: SessionStore) {
        self.sessionStore = sessionStore
    }

    func accessToken() -> String? {
        sessionStore.accessToken
    }
}
