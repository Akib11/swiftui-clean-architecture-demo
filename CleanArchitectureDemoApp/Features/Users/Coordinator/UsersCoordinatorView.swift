//
//  UsersCoordinatorView.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 01/04/2026.
//

import Foundation
import SwiftUI

struct UsersCoordinatorView: View {
    
    let container: DependencyContainer
    @State private var path = NavigationPath()
    
    var body: some View {
        let _ = print("✅ UsersCoordinatorView rendered")
        NavigationStack(path: $path) {
            UsersView(viewModel: container.makeUsersViewModel())
                .navigationTitle("Users")
        }
    }
}
