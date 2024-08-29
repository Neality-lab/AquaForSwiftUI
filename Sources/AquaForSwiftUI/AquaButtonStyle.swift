//
//  AquaButtonStyle.swift
//  Aqua Button
//
//  Created by Yohey Kuwa on 2024/08/22.
//

import SwiftUI

public struct AquaButtonStyle: ButtonStyle {
    var aquaColor: Color
    var colorShadow: Bool
    var shape: AquaFrameShape
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .aquaFrameModifier(aquaColor: aquaColor, aquaOpacity: 0.15, colorShadow: colorShadow, shape: shape)
            .opacity(configuration.isPressed ? 0.7 : 1.0) // Dim the button when pressed
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0) // Slightly scale down the button when pressed
            .buttonStyle(PlainButtonStyle()) // Ensure the button behaves as a plain button without additional styles
    }
}

public extension View {
    func aquaButtonStyle(aquaColor: Color, colorShadow: Bool = true, shape: AquaFrameShape = .capsule) -> some View {
        self.buttonStyle(AquaButtonStyle(aquaColor: aquaColor, colorShadow: colorShadow, shape: shape))
    }
}
