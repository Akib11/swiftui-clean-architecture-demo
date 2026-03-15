//
//  SessionStore.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 15/03/2026.
//
import Foundation
import Combine

final class SessionStore: ObservableObject {

    /// Demo placeholder for authenticated session state
    @Published var accessToken: String? = nil
    
    var isAuthenticated: Bool {
        accessToken != nil
    }
}
