//
//  RootTabView.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 15/03/2026.
//

import Foundation
import SwiftUI

struct RootTabView: View {
    
    @EnvironmentObject private var coordinator: AppCoordinator
    @State private var selectedTab: AppTab = .users
    
    var body: some View {
        TabView(selection: $selectedTab) {
            UsersCoordinatorView(container: coordinator.container)
                .tabItem {
                    Label(AppTab.users.title, systemImage: AppTab.users.systemImage)
                }
                .tag(AppTab.users)
            
            FavouriteUsersCoordinatorView(container: coordinator.container)
                .tabItem {
                    Label(AppTab.favouriteUsers.title, systemImage: AppTab.favouriteUsers.systemImage)
                }
                .tag(AppTab.favouriteUsers)
        }
    }
}
