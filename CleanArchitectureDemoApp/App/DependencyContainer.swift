//
//  DependencyContainer.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 10/03/2026.
//

import Foundation
import SwiftData


final class DependencyContainer {
     
     private let modelContext: ModelContext
     
     init(modelContext: ModelContext) {
         self.modelContext = modelContext
     }
     
     // MARK: - Users Services
     
     func makeUsersService() -> UsersServiceProtocol {
         UsersService(router: Router<UsersAPI>())
     }
     
     func makeUsersCacheService() -> UsersCacheServiceProtocol {
         UsersCacheService(modelContext: modelContext)
     }
     
     // MARK: - Users Repository
     
     func makeUsersRepository() -> UsersRepositoryProtocol {
         UsersRepository(
             remoteService: makeUsersService(),
             cacheService: makeUsersCacheService()
         )
     }
     
     // MARK: - Users UseCases
     
     func makeGetUsersUseCase() -> GetUsersUseCaseProtocol {
         GetUsersUseCase(repository: makeUsersRepository())
     }
     
     // MARK: - Favourite Users Cache
     
     func makeFavouriteUsersCacheService() -> FavouriteUsersCacheServiceProtocol {
         FavouriteUsersCacheService(modelContext: modelContext)
     }
     
     // MARK: - Favourite Users Repository
     
     func makeFavouriteUsersRepository() -> FavouriteUsersRepositoryProtocol {
         FavouriteUsersRepository(
             cacheService: makeFavouriteUsersCacheService()
         )
     }
     
     // MARK: - Favourite Users UseCases
     
     func makeGetFavouriteUsersUseCase() -> GetFavouriteUsersUseCaseProtocol {
         GetFavouriteUsersUseCase(
             repository: makeFavouriteUsersRepository()
         )
     }
     
     func makeAddFavouriteUserUseCase() -> AddFavouriteUserUseCaseProtocol {
         AddFavouriteUserUseCase(
             repository: makeFavouriteUsersRepository()
         )
     }
     
     func makeRemoveFavouriteUserUseCase() -> RemoveFavouriteUserUseCaseProtocol {
         RemoveFavouriteUserUseCase(
             repository: makeFavouriteUsersRepository()
         )
     }
     
     func makeIsFavouriteUserUseCase() -> IsFavouriteUserUseCaseProtocol {
         IsFavouriteUserUseCase(
             repository: makeFavouriteUsersRepository()
         )
     }
     
     // MARK: - ViewModels
     
     func makeUsersViewModel() -> UsersViewModel {
         UsersViewModel(
             getUsersUseCase: makeGetUsersUseCase(),
             getFavouriteUsersUseCase: makeGetFavouriteUsersUseCase(),
             addFavouriteUserUseCase: makeAddFavouriteUserUseCase(),
             removeFavouriteUserUseCase: makeRemoveFavouriteUserUseCase()
         )
     }
     
     func makeFavouriteUsersViewModel() -> FavouriteUsersViewModel {
         FavouriteUsersViewModel(
             getFavouriteUsersUseCase: makeGetFavouriteUsersUseCase(),
             removeFavouriteUserUseCase: makeRemoveFavouriteUserUseCase()
         )
     }
 }

