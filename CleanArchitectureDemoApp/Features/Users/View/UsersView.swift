//
//  DashboardView.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 10/03/2026.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    
    @StateObject var viewModel: UsersViewModel
    
    var body: some View {
        let _ = print("✅ UsersView body rendered")
        content
            .task {
                print("✅ UsersView .task fired")
                await viewModel.loadUsers()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
            
        case .idle:
            ProgressView("Loading users...")
            
        case .loading:
            ProgressView()
            
        case .success(let users):
            UserListView(
                users: users,
                isFavourite: { user in
                    viewModel.isFavourite(user)
                },
                onFavouriteTapped: { user in
                    viewModel.toggleFavourite(user: user)
                }
            )
            
        case .failure(let message):
            errorView(message)
        }
    }
}


private extension UsersView {
    
    func errorView(_ message: String) -> some View {
        VStack {
            Text("Something went wrong")
            Text(message)
                .font(.caption)
        }
    }
}


#Preview {
    let favouritesCache = MockFavouriteUsersCacheService()
    try? favouritesCache.save(user: User.samples[0])
    try? favouritesCache.save(user: User.samples[1])
    
    return UsersView(
        viewModel: UsersViewModel(
            repository: UsersRepository(
                remoteService: MockUsersService(),
                cacheService: MockUsersCacheService()
            ),
            favouritesRepository: FavouriteUsersRepository(
                cacheService: favouritesCache
            )
        )
    )
}
