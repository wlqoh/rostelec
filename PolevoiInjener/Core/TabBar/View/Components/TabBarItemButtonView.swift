//
//  TabBarItemButtonView.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import SwiftUI

struct TabBarItemButtonView: View {
    let item: TabBarItem
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: item.iconName)
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
