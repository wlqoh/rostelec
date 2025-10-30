//
//  TabBarViewModel.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import Combine

final class TabBarViewModel: ObservableObject {
    @Published private(set) var selectedDestination: TabBarDestination
    let items: [TabBarItem]
    private let actionHandler: (() -> Void)?

    init(
        selectedDestination: TabBarDestination = .route,
        items: [TabBarItem] = TabBarItem.defaults(),
        actionHandler: (() -> Void)? = nil
    ) {
        self.selectedDestination = selectedDestination
        self.items = items
        self.actionHandler = actionHandler
    }

    func select(_ destination: TabBarDestination) {
        guard selectedDestination != destination else { return }
        selectedDestination = destination
    }

    func performAction() {
        actionHandler?()
    }
}
