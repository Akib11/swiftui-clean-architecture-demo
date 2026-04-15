//
//  FavouriteUsersCoordinatorView.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 01/04/2026.
//

import Foundation
import SwiftUI

struct FavouriteUsersCoordinatorView: View {
    
    @StateObject private var viewModel: FavouriteUsersViewModel
    
    init(container: DependencyContainer) {
        _viewModel = StateObject(
            wrappedValue: container.makeFavouriteUsersViewModel()
        )
    }
    
    var body: some View {
        NavigationStack {
            FavouriteUsersView(viewModel: viewModel)
                .navigationTitle("Fav Users")
        }
    }
}
