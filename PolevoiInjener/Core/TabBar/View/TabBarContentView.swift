//
//  TabBarContentView.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import SwiftUI

struct TabBarContentView: View {
    let selectedDestination: TabBarDestination

    var body: some View {
        Group {
            switch selectedDestination {
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
    }
}
