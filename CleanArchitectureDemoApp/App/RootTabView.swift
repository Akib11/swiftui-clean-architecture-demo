//
//  RootTabView.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 15/03/2026.
//

import SwiftUI
import SwiftData

struct RootTabView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var selectedTab: AppTab = .users
    
    var body: some View {
        let container = DependencyContainer(modelContext: modelContext)
        
        TabView(selection: $selectedTab) {
            UsersCoordinatorView(container: container)
                .tabItem {
                    Label(AppTab.users.title, systemImage: AppTab.users.systemImage)
                }
                .tag(AppTab.users)
        }
    }
}
