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
    
    private let service: UsersServiceProtocol
    
    @Published var state: ViewState<[User]> = .idle
    
    private var page = 1
    
    init(service: UsersServiceProtocol) {
        self.service = service
    }
    
    func loadUsers() async {
        
        // Prevent duplicate loading
        if case .loading = state { return }
        
        state = .loading
        
        do {
            let users = try await service.getUsers(page: page, results: 20)
            
            state = .success(users)
            page += 1
            
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
