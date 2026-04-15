//
//  UserListView.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 02/04/2026.
//

import Foundation
import SwiftUI



// MARK: - Avatar View

struct AsyncAvatarView: View {
    let urlString: String
    let size: CGFloat

    var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure(_), .empty:
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .padding(size * 0.2)
                    .foregroundColor(.white.opacity(0.8))
            @unknown default:
                Color.clear
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
}

// MARK: - User Row Card

struct UserRowCard: View {
    let user: User
    let isFavourite: Bool
    let onFavouriteTapped: () -> Void
    
    @State private var isPressed = false
    
    var initials: String {
        let parts = user.fullName.split(separator: " ")
        let letters = parts.prefix(2).compactMap { $0.first }
        return String(letters).uppercased()
    }
    
    var avatarGradient: LinearGradient {
        let sum = user.id.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        let hue = Double(sum % 256) / 255.0
        
        return LinearGradient(
            colors: [
                Color(hue: hue, saturation: 0.55, brightness: 0.75),
                Color(hue: fmod(hue + 0.15, 1.0), saturation: 0.65, brightness: 0.60)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var body: some View {
        HStack(spacing: 14) {
            
            // Avatar
            ZStack {
                Circle()
                    .fill(avatarGradient)
                    .frame(width: 52, height: 52)
                
                Text(initials)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                // Overlay async image on top
                AsyncAvatarView(urlString: user.avatarURL, size: 52)
            }
            .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 2)
            
            // Info
            VStack(alignment: .leading, spacing: 3) {
                Text(user.fullName)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
                
                HStack(spacing: 4) {
                    Image(systemName: "envelope.fill")
                        .font(.system(size: 10))
                        .foregroundColor(.secondary.opacity(0.7))
                    Text(user.email)
                        .font(.system(size: 13, weight: .regular, design: .monospaced))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            favButton
            
            // Chevron
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary.opacity(0.4))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: .black.opacity(0.07), radius: 8, x: 0, y: 2)
        )
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .onTapGesture {
            isPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                isPressed = false
            }
        }
    }
    
    
    var favButton: some View {
    Button(action: onFavouriteTapped) {
        Image(systemName: isFavourite ? "heart.fill" : "heart")
            .foregroundColor(isFavourite ? .red : .gray)
            .font(.system(size: 18, weight: .semibold))
            .padding(8)
            .background(.ultraThinMaterial)
            .clipShape(Circle())
    }
    .buttonStyle(.plain)
   }
}

// MARK: - Main List View

struct UserListView: View {
    let users: [User]
    let isFavourite: (User) -> Bool
    let onFavouriteTapped: (User) -> Void

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    HStack {
                        Text("\(users.count) members")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(
                                Capsule()
                                    .fill(Color(.secondarySystemBackground))
                            )

                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 16)

                    LazyVStack(spacing: 10) {
                        ForEach(users, id: \.id) { user in
                            UserRowCard(
                                user: user,
                                isFavourite: isFavourite(user),
                                onFavouriteTapped: {
                                    onFavouriteTapped(user)
                                }
                            )
                            .padding(.horizontal, 20)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationTitle("Team")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // Add user action
                } label: {
                    Image(systemName: "person.badge.plus")
                        .font(.system(size: 17, weight: .medium))
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var favourites: Set<String> = []
    
    var body: some View {
        UserListView(
            users: User.samples,
            isFavourite: { user in
                favourites.contains(user.id)
            },
            onFavouriteTapped: { user in
                if favourites.contains(user.id) {
                    favourites.remove(user.id)
                } else {
                    favourites.insert(user.id)
                }
            }
        )
    }
}
