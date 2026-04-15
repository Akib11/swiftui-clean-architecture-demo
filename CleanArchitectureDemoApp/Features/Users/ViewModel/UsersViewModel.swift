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
    private let favouritesRepository: FavouriteUsersRepositoryProtocol
    
    @Published var state: ViewState<[User]> = .idle
    @Published var favouriteIds: Set<String> = []
    
    private var page = 1
    
    init(
        repository: UsersRepositoryProtocol,
        favouritesRepository: FavouriteUsersRepositoryProtocol
    ) {
        self.repository = repository
        self.favouritesRepository = favouritesRepository
    }
    
    func loadUsers() async {
        if case .loading = state { return }
        
        state = .loading
        
        do {
            let users = try await repository.getUsers(page: page, results: 20)
            print("🔴🔴🔴🔴 User: ", users.count)
            state = .success(users)
            page += 1
            
            loadFavourites()
            
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
    
    func loadFavourites() {
        do {
            let favourites = try favouritesRepository.getFavouriteUsers()
            favouriteIds = Set(favourites.map { $0.id })
        } catch {
            print(error)
        }
    }
    
    func toggleFavourite(user: User) {
        do {
            if favouriteIds.contains(user.id) {
                try favouritesRepository.removeFromFavourites(userId: user.id)
                favouriteIds.remove(user.id)
            } else {
                try favouritesRepository.addToFavourites(user: user)
                favouriteIds.insert(user.id)
            }
        } catch {
            print(error)
        }
    }
    
    func isFavourite(_ user: User) -> Bool {
        favouriteIds.contains(user.id)
    }
}
