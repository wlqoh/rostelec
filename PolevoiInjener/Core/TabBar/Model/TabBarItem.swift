//
//  TabBarItem.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import Foundation

struct TabBarItem: Identifiable {
    let destination: TabBarDestination
    let iconName: String
    let title: String

    var id: TabBarDestination { destination }
}

extension TabBarItem {
    static func defaults() -> [TabBarItem] {
        TabBarDestination.allCases.map {
            TabBarItem(destination: $0, iconName: $0.systemImageName, title: $0.title)
        }
    }
}
