//
//  UsersViewModel.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 01/04/2026.
//

import Foundation
import Combine

@MainActor
final class UsersViewModel: ObservableObject {
    
    private let repository: UsersRepositoryProtocol
    
    @Published var state: ViewState<[User]> = .idle
    
    private var page = 1
    
    init(repository: UsersRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadUsers() async {
        
        // Prevent duplicate loading
        if case .loading = state { return }
        
        state = .loading
        
        do {
            let users = try await repository.getUsers(page: page, results: 20)
            print("🔴🔴🔴🔴 User: ", users.count)
            state = .success(users)
            page += 1
            
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
