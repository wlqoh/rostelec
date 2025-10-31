//
//  TabBarView.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import SwiftUI

struct TabBarView: View {
    @StateObject private var viewModel: TabBarViewModel
    @State private var isAddRequestPresented: Bool = false

    init(viewModel: TabBarViewModel = TabBarViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabBarContentView(selectedDestination: viewModel.selectedDestination)

            TabBarControlView(
                items: viewModel.items,
                selectedDestination: viewModel.selectedDestination,
                onSelect: { viewModel.select($0) },
                onAction: handleAddRequestTap
            )
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .fullScreenCover(isPresented: $isAddRequestPresented) {
            AddRequestView()
                .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    TabBarView()
        .preferredColorScheme(.dark)
}

private extension TabBarView {
    func handleAddRequestTap() {
        viewModel.performAction()
        isAddRequestPresented = true
    }
}
