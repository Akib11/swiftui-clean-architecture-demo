//
//  FavouriteUsersCoordinatorView.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 01/04/2026.
//

import Foundation
import SwiftUI

struct FavouriteUsersCoordinatorView: View {
    
    let container: DependencyContainer
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            FavouriteUsersView()
                .navigationTitle("Fav Users")
        }
    }
}
