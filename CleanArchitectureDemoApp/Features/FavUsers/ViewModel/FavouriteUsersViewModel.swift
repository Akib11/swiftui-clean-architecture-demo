//
//  FavouriteUsersViewModel.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 15/04/2026.
//

import Foundation
import Combine

@MainActor
final class FavouriteUsersViewModel: ObservableObject {
    
    private let repository: FavouriteUsersRepositoryProtocol
    
    @Published var state: ViewState<[User]> = .idle
    
    init(repository: FavouriteUsersRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadFavourites() {
        do {
            let users = try repository.getFavouriteUsers()
            state = .success(users)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
    
    func removeFavourite(userId: String) {
        do {
            try repository.removeFromFavourites(userId: userId)
            loadFavourites()
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
