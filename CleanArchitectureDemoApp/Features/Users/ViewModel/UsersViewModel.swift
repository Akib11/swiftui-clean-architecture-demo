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
    
    private let getUsersUseCase: GetUsersUseCaseProtocol
    private let getFavouriteUsersUseCase: GetFavouriteUsersUseCaseProtocol
    private let addFavouriteUserUseCase: AddFavouriteUserUseCaseProtocol
    private let removeFavouriteUserUseCase: RemoveFavouriteUserUseCaseProtocol
    
    @Published var state: ViewState<[User]> = .idle
    @Published var favouriteIds: Set<String> = []
    
    private var page = 1
    
    init(
        getUsersUseCase: GetUsersUseCaseProtocol,
        getFavouriteUsersUseCase: GetFavouriteUsersUseCaseProtocol,
        addFavouriteUserUseCase: AddFavouriteUserUseCaseProtocol,
        removeFavouriteUserUseCase: RemoveFavouriteUserUseCaseProtocol
    ) {
        self.getUsersUseCase = getUsersUseCase
        self.getFavouriteUsersUseCase = getFavouriteUsersUseCase
        self.addFavouriteUserUseCase = addFavouriteUserUseCase
        self.removeFavouriteUserUseCase = removeFavouriteUserUseCase
    }
    
    func loadUsers() async {
        
        if case .loading = state { return }
        
        state = .loading
        
        do {
            let users = try await getUsersUseCase.execute(
                page: page,
                results: 20
            )
            
            state = .success(users)
            page += 1
            
            loadFavourites()
            
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
    
    func loadFavourites() {
        do {
            let favourites = try getFavouriteUsersUseCase.execute()
            favouriteIds = Set(favourites.map(\.id))
        } catch {
            print("Failed loading favourites: \(error)")
        }
    }
    
    func toggleFavourite(user: User) {
        do {
            if favouriteIds.contains(user.id) {
                
                try removeFavouriteUserUseCase.execute(
                    userId: user.id
                )
                
                favouriteIds.remove(user.id)
                
            } else {
                
                try addFavouriteUserUseCase.execute(
                    user: user
                )
                
                favouriteIds.insert(user.id)
            }
            
        } catch {
            print("Failed toggling favourite: \(error)")
        }
    }
    
    func isFavourite(_ user: User) -> Bool {
        favouriteIds.contains(user.id)
    }
}
