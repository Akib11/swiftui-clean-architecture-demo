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
            usersList(users)
            
        case .failure(let message):
            errorView(message)
        }
    }
}


private extension UsersView {
    
    func usersList(_ users: [User]) -> some View {
        List(users) { user in
            HStack {
                AsyncImage(url: URL(string: user.avatarURL))
                Text(user.fullName)
            }
        }
    }
    
    func errorView(_ message: String) -> some View {
        VStack {
            Text("Something went wrong")
            Text(message)
                .font(.caption)
        }
    }
}

#Preview {
    UsersView(
        viewModel: UsersViewModel(
            service: MockUsersService()
        )
    )
}
