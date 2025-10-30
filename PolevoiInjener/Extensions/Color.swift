//
//  Color.swift
//  PolevoiInjener
//
//  Created by Мурад on 30/10/25.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let secondaryColor = Color("SecondaryColor")
    let primaryColor = Color("PrimaryColor")
    let surfaceColor = Color(red: 0.09, green: 0.11, blue: 0.20)
    let elevatedSurfaceColor = Color(red: 0.11, green: 0.13, blue: 0.24)
    let violetAccent = Color(red: 0.45, green: 0.43, blue: 0.96)
    let greenAccent = Color(red: 0.28, green: 0.83, blue: 0.53)
    let amberAccent = Color(red: 0.98, green: 0.70, blue: 0.29)
}
