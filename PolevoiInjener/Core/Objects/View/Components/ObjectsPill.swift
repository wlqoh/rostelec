//
//  ObjectsPill.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import SwiftUI

struct ObjectsPill: View {
    let text: String
    var foreground: Color = .white
    var background: Color = Color.white.opacity(0.12)

    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(foreground)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule(style: .continuous)
                    .fill(background)
            )
    }
}
