//
//  AquaToggle.swift
//  Aqua Button
//
//  Created by Yohey Kuwa on 2024/08/26.
//

import SwiftUI

public struct AquaToggleStyle: ToggleStyle {
    public enum Style {
        case toggle
        case push
    }
    
    var style: Style
    
    var aquaColor: Color
    var colorShadow: Bool
    ///var shape: AquaFrameShape
    
    @State private var position: CGFloat = 0
    
    public func makeBody(configuration: Configuration) -> some View {
        switch style {
        case .toggle:
            GeometryReader { geo in
                HStack {
                    configuration.label
                    
                    Spacer()
                    
                    let width = geo.size.height * 1.7
                    let height = geo.size.height
                    let padding = geo.size.height / 20
                    
                    // Toggle knob (circle part)
                    Capsule()
                        .foregroundColor(.clear)
                        .aquaFrameModifier(
                            aquaColor: configuration.isOn ? .white.opacity(0.45) : aquaColor,
                            colorShadow: false,
                            shape: .capsule
                        )
                        .frame(width: height, height: height)
                        .offset(x: position)
                        .background(alignment: .trailing) {
                            // Background track
                            Capsule()
                                .foregroundStyle(configuration.isOn ? aquaColor : .gray.opacity(0.25))
                                .frame(width: width)
                                .overlay {
                                    // Cast a shadow gradient
                                    ZStack {
                                        Capsule()
                                            .foregroundStyle(
                                                LinearGradient(colors: [.black, .white.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                                            )
                                        Capsule()
                                            .padding(padding * 2)
                                            .blur(radius: padding * 2)
                                            .blendMode(.destinationOut)
                                    }
                                    .compositingGroup()
                                    .blendMode(.overlay)
                                    .clipShape(Capsule())
                                }
                                .padding(-padding)
                        }
                        .onTapGesture {
                            // Handle toggle switch
                            withAnimation(.bouncy(duration: 0.3, extraBounce: 0.025)) {
                                configuration.isOn.toggle()
                            }
                        }
                        .onChange(of: configuration.isOn) {
                            withAnimation(.bouncy(duration: 0.3, extraBounce: 0.025)) {
                                if configuration.isOn {
                                    position = 0
                                } else {
                                    position = -(width - height) + padding * 2
                                }
                            }
                        }
                        .onAppear {
                            // Initialize position based on isOn state
                            if configuration.isOn {
                                position = 0
                            } else {
                                position = -(width - height) + padding * 2
                            }
                        }
                }
            }
            .frame(height: 30)

        case .push:
            configuration.label
                .padding(10) // Button padding
                .aquaFrameModifier(
                    aquaColor: configuration.isOn ? aquaColor : .gray.opacity(0.25),
                    aquaOpacity: 0.15,
                    shape: .capsule
                )
                .onTapGesture {
                    // Handle button press
                    withAnimation(.bouncy(duration: 0.3, extraBounce: 0.025)) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

public extension View {
    func aquaToggleStyle(style: AquaToggleStyle.Style, aquaColor: Color, colorShadow: Bool = true) -> some View {
        self.toggleStyle(AquaToggleStyle(style: style, aquaColor: aquaColor, colorShadow: colorShadow))
    }
}
