//
//  CleanArchitectureDemoAppApp.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 10/03/2026.
//

import SwiftUI
import SwiftData

@main
struct CleanArchitectureDemoAppApp: App {

    @StateObject private var coordinator = AppCoordinator()
        
        var body: some Scene {
            WindowGroup {
                RootTabView()
                    .environmentObject(coordinator)
            }
        }
}
