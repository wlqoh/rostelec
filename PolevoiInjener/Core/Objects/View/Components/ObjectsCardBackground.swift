//
//  ObjectsCardBackground.swift
//  PolevoiInjener
//
//  Created by Codex on 31/10/25.
//

import SwiftUI

struct ObjectsCardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(22)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .fill(Color.theme.primaryColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 26, style: .continuous)
                            .stroke(Color.white.opacity(0.05), lineWidth: 1)
                    )
            )
    }
}

extension View {
    func objectsCard() -> some View {
        modifier(ObjectsCardBackground())
    }
}
