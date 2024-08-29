//
//  AquaFrameModifier.swift
//  Aqua Button
//
//  Created by Yohey Kuwa on 2024/08/22.
//

import SwiftUI

// Custom view modifier that applies an Aqua-style frame effect to any view.
public struct AquaFrameModifier: ViewModifier {
    var colorMaterial: Bool = true
    var aquaColor: Color
    var aquaOpacity: CGFloat
    var colorShadow: Bool
    var shape: AquaFrameShape
    var highlight: Bool = true
    
    public func body(content: Content) -> some View {
        content
            .mask( // Mask content with the selected shape
                Group {
                    switch shape {
                    case .capsule:
                        Capsule()
                    case .rectangle(let cornerRadius):
                        RoundedRectangle(cornerRadius: cornerRadius)
                    }
                }
            )
            .overlay(
                GeometryReader { geo in
                    let edgePadding = geo.size.height / 30 // Edge padding based on the height of the view
                    
                    ZStack {
                        // Base shape with optional color shadow
                        Group {
                            switch shape {
                            case .capsule:
                                Capsule()
                            case .rectangle(let cornerRadius):
                                RoundedRectangle(cornerRadius: cornerRadius)
                            }
                        }
                        .foregroundStyle(aquaColor.opacity(1)) // Main button color
                        .shadow(radius: edgePadding / 2) // Subtle shadow for depth
                        .shadow(
                            color: colorShadow ? aquaColor.opacity(0.35) : .clear, // Conditional shadow color
                            radius: colorShadow ? geo.size.height / 20 : 0, // Conditional shadow radius
                            y: colorShadow ? geo.size.height / 10 : 0 // Conditional shadow y-offset
                        )
                        
                        content
                            .mask(
                                Group {
                                    switch shape {
                                    case .capsule:
                                        Capsule()
                                    case .rectangle(let cornerRadius):
                                        RoundedRectangle(cornerRadius: cornerRadius)
                                    }
                                }
                                .padding(edgePadding * 4)
                                .blur(radius: edgePadding * 2)
                            )
                            .opacity(1 - aquaOpacity)
                        
                        ZStack {
                            // Gradient overlay for highlight effect
                            Group {
                                switch shape {
                                case .capsule:
                                    Capsule()
                                case .rectangle(let cornerRadius):
                                    RoundedRectangle(cornerRadius: cornerRadius - edgePadding / 2)
                                }
                            }
                            .foregroundStyle(
                                LinearGradient(
                                    gradient: Gradient(colors: [.white.opacity(0), .white.opacity(0.1), .white.opacity(0.3), .white.opacity(1)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .blur(radius: edgePadding / 2) // Soften the gradient edges
                            .blendMode(.overlay) // Blend mode for gradient overlay
                            
                            ZStack {
                                // Reflection effect
                                Group {
                                    switch shape {
                                    case .capsule:
                                        Capsule()
                                    case .rectangle(let cornerRadius):
                                        RoundedRectangle(cornerRadius: cornerRadius - edgePadding / 2)
                                    }
                                }
                                .foregroundStyle(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.white.opacity(0.95), .white.opacity(0.2), .white.opacity(0)]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .mask(
                                    Group {
                                        switch shape {
                                        case .capsule:
                                            Capsule()
                                                .offset(y: -geo.size.height / 2 + edgePadding * 9) // Position reflection for Capsule
                                                .padding(.vertical, edgePadding * 3)
                                                .padding(.horizontal, edgePadding * 3)
                                            
                                        case .rectangle:
                                            Ellipse()
                                                .scaleEffect(x: 1.5)
                                                .offset(y: -geo.size.height / 2 + edgePadding * 4) // Position reflection for Rectangle
                                        }
                                    }
                                )
                                
                                // Highlight effect (applied only if highlight is true)
                                if highlight {
                                    Group {
                                        switch shape {
                                        case .capsule:
                                            Capsule()
                                                .foregroundStyle(.white.opacity(0.8))
                                                .mask(
                                                    ZStack {
                                                        Capsule() // Full-sized highlight shape
                                                        
                                                        Capsule()
                                                            .offset(y: edgePadding * 1.2) // Offset highlight shape to create cut-out effect
                                                            .blendMode(.destinationOut) // Blend mode for cut-out effect
                                                        
                                                    }
                                                        .compositingGroup() // Combine shapes to create final highlight effect
                                                        .mask(
                                                            Capsule()
                                                                .offset(y: -geo.size.height / 2 + edgePadding * 9) // Position reflection for Capsule
                                                                .padding(.vertical, edgePadding * 3)
                                                                .padding(.horizontal, edgePadding * 3)
                                                        )
                                                )
                                            
                                        case .rectangle(let cornerRadius):
                                            RoundedRectangle(cornerRadius: cornerRadius - edgePadding)
                                                .foregroundStyle(.white.opacity(0.8))
                                                .mask(
                                                    ZStack {
                                                        RoundedRectangle(cornerRadius: cornerRadius - edgePadding) // Full-sized highlight shape
                                                        
                                                        RoundedRectangle(cornerRadius: cornerRadius - edgePadding)
                                                            .offset(y: edgePadding * 1.2) // Offset highlight shape to create cut-out effect
                                                            .blendMode(.destinationOut) // Blend mode for cut-out effect
                                                        
                                                    }
                                                    .compositingGroup() // Combine shapes to create final highlight effect
                                                    .mask(
                                                        Ellipse()
                                                            .scaleEffect(x: 1.5)
                                                            .offset(y: -geo.size.height / 2 + edgePadding * 4) // Align with reflection
                                                    )
                                                )
                                        }
                                    }
                                }
                            }
                            .blur(radius: edgePadding / 5) // Blur effect for highlight
                        }
                        .padding(edgePadding) // Additional padding for inner ZStack
                    }
                }
            )
    }
}

// Enum to define the shape options for the frame
public enum AquaFrameShape {
    case capsule
    case rectangle(cornerRadius: CGFloat)
}

// Extension to easily apply the AquaFrameModifier to any view
public extension View {
    public func aquaFrameModifier(aquaColor: Color, aquaOpacity: CGFloat = 0.5, colorShadow: Bool = true, shape: AquaFrameShape) -> some View {
        self.modifier(AquaFrameModifier(aquaColor: aquaColor, aquaOpacity: aquaOpacity, colorShadow: colorShadow, shape: shape))
    }
}
