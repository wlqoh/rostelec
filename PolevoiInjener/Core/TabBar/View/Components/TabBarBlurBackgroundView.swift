//
//  TabBarBlurBackgroundView.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import SwiftUI

struct TabBarBlurBackgroundView: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color.theme.primaryColor.opacity(0.65),
                Color.theme.primaryColor.opacity(0.95)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}
