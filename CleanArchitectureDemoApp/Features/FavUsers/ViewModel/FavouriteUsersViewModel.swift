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
    
    private let getFavouriteUsersUseCase: GetFavouriteUsersUseCaseProtocol
    private let removeFavouriteUserUseCase: RemoveFavouriteUserUseCaseProtocol
    
    @Published var state: ViewState<[User]> = .idle
    
    init(
        getFavouriteUsersUseCase: GetFavouriteUsersUseCaseProtocol,
        removeFavouriteUserUseCase: RemoveFavouriteUserUseCaseProtocol
    ) {
        self.getFavouriteUsersUseCase = getFavouriteUsersUseCase
        self.removeFavouriteUserUseCase = removeFavouriteUserUseCase
    }
    
    func loadFavourites() {
        do {
            let users = try getFavouriteUsersUseCase.execute()
            state = .success(users)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
    
    func removeFavourite(userId: String) {
        do {
            try removeFavouriteUserUseCase.execute(userId: userId)
            loadFavourites()
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
