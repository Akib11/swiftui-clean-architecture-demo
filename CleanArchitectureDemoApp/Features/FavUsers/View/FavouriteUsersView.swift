//
//  FavouriteUsersView.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 01/04/2026.
//

import Foundation
import SwiftUI

struct FavouriteUsersView: View {
    
    @ObservedObject var viewModel: FavouriteUsersViewModel
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .idle:
                emptyView
            case .loading:
                ProgressView()
            case .success(let users):
                if users.isEmpty {
                    emptyView
                } else {
                    List(users) { user in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullName)
                                .font(.headline)
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            case .failure(let message):
                VStack {
                    Text("Something went wrong")
                    Text(message)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .onAppear {
            viewModel.loadFavourites()
        }
    }
    
    private var emptyView: some View {
        VStack(spacing: 12) {
            Image(systemName: "heart")
                .font(.largeTitle)
            Text("No favourite users yet")
                .font(.headline)
            Text("Users you save will appear here.")
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}
