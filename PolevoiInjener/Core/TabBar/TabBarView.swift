//
//  TabBarView.swift
//  PolevoiInjener
//
//  Created by Мурад on 30/10/25.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: Tabs = .route

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .route:
                    RouteView()
                case .objects:
                    ObjectsView()
                case .clients:
                    ContactsView()
                case .profile:
                    ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.theme.backgroundColor)
            .ignoresSafeArea()

            TabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

private struct TabBar: View {
    @Binding var selectedTab: Tabs

    var body: some View {
        ZStack {
            BlurBackground()

            HStack(spacing: 0) {
                TabButton(
                    item: .init(tab: .route, icon: "mappin.and.ellipse", title: "Маршрут"),
                    isSelected: selectedTab == .route,
                    action: { selectedTab = .route }
                )
                TabButton(
                    item: .init(tab: .objects, icon: "building.2.fill", title: "Объекты"),
                    isSelected: selectedTab == .objects,
                    action: { selectedTab = .objects }
                )
                TabButton(
                    item: .init(tab: .clients, icon: "person.2.fill", title: "Клиенты"),
                    isSelected: selectedTab == .clients,
                    action: { selectedTab = .clients }
                )
                TabButton(
                    item: .init(tab: .profile, icon: "person.crop.circle", title: "Профиль"),
                    isSelected: selectedTab == .profile,
                    action: { selectedTab = .profile }
                )
            }
            .padding(.horizontal, 12)
            .padding(.top, 10)
            .padding(.bottom, 24)
            .overlay(alignment: .top) {
                ActionButton()
                    .offset(y: -28)
            }
        }
        .frame(height: 96)
        .background(Color.theme.primaryColor)
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .padding(.horizontal, 24)
        .padding(.bottom, 12)
        .shadow(color: .black.opacity(0.2), radius: 16, x: 0, y: -4)
    }
}

private struct TabButton: View {
    let item: TabBarItem
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: item.icon)
                    .font(.system(size: 20, weight: .semibold))
                Text(item.title)
                    .font(.system(size: 11, weight: .medium))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
            .foregroundStyle(isSelected ? Color.theme.secondaryColor : Color.white.opacity(0.55))
        }
    }
}

private struct ActionButton: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "plus")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(Color.white)
                .frame(width: 58, height: 58)
                .background(
                    Circle()
                        .fill(Color.theme.secondaryColor)
                )
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.12), lineWidth: 6)
                        .blur(radius: 4)
                        .offset(y: 3)
                        .mask(Circle().fill(LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)))
                )
        }
        .offset(y: -20)
        .shadow(color: Color.theme.secondaryColor.opacity(0.45), radius: 20, x: 0, y: 10)
    }
}

private struct BlurBackground: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color.black.opacity(0.35),
                Color.black.opacity(0.6)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

private struct TabBarItem: Identifiable {
    let id = UUID()
    let tab: Tabs
    let icon: String
    let title: String
}

enum Tabs {
    case route
    case objects
    case clients
    case profile
}

#Preview {
    TabBarView()
        .preferredColorScheme(.dark)
}
