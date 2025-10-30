//
//  TabBarDestination.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import Foundation

enum TabBarDestination: CaseIterable, Identifiable {
    case route
    case objects
    case clients
    case profile

    var id: Self { self }
}

extension TabBarDestination {
    var title: String {
        switch self {
        case .route:
            return "Маршрут"
        case .objects:
            return "Объекты"
        case .clients:
            return "Клиенты"
        case .profile:
            return "Профиль"
        }
    }

    var systemImageName: String {
        switch self {
        case .route:
            return "mappin.and.ellipse"
        case .objects:
            return "building.2.fill"
        case .clients:
            return "person.2.fill"
        case .profile:
            return "person.crop.circle"
        }
    }
}
