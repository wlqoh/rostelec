//
//  TabBarActionButtonView.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import SwiftUI

struct TabBarActionButtonView: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
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
                        .mask(
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.clear, .black],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                        )
                )
        }
        .offset(y: -10)
        .shadow(color: Color.theme.secondaryColor.opacity(0.45), radius: 20, x: 0, y: 10)
    }
}
