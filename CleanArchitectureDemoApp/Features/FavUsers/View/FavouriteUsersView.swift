//
//  FavouriteUsersView.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 01/04/2026.
//

import Foundation
import SwiftUI

struct FavouriteUsersView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "heart.fill")
                .font(.largeTitle)
            
            Text("Favourite Users")
                .font(.title2.bold())
            
            Text("Your saved users will appear here.")
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}
