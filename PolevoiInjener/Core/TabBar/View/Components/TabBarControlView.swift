//
//  TabBarControlView.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import SwiftUI

struct TabBarControlView: View {
    let items: [TabBarItem]
    let selectedDestination: TabBarDestination
    let onSelect: (TabBarDestination) -> Void
    let onAction: () -> Void

    private var leadingItems: [TabBarItem] {
        Array(items.prefix(2))
    }

    private var trailingItems: [TabBarItem] {
        let count = max(items.count - 2, 0)
        return Array(items.suffix(count))
    }

    var body: some View {
        ZStack {
            TabBarBlurBackgroundView()

            HStack(spacing: 0) {
                ForEach(leadingItems) { item in
                    TabBarItemButtonView(
                        item: item,
                        isSelected: item.destination == selectedDestination,
                        action: { onSelect(item.destination) }
                    )
                }

                Spacer(minLength: 0)

                TabBarActionButtonView(action: onAction)

                Spacer(minLength: 0)

                ForEach(trailingItems) { item in
                    TabBarItemButtonView(
                        item: item,
                        isSelected: item.destination == selectedDestination,
                        action: { onSelect(item.destination) }
                    )
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 10)
            .padding(.bottom, 24)
        }
        .frame(height: 96)
        .background(Color.theme.primaryColor)
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .padding(.horizontal, 24)
        .padding(.bottom, 12)
        .shadow(color: .black.opacity(0.2), radius: 16, x: 0, y: -4)
    }
}
