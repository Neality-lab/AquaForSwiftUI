# AquaForSwiftUI

## Overview
**AquaForSwiftUI** is a library for custom styles and modifiers for SwiftUI applications. It includes key components like `AquaButtonStyle`, `AquaToggleStyle`, and `AquaFrameModifier`, designed to enhance the UI of SwiftUI apps with sophisticated design and customization options. Both `AquaButtonStyle` and `AquaToggleStyle` are built upon `AquaFrameModifier` to provide consistent and customizable styling.

## Installation

### Swift Package Manager
1. Open your project in Xcode.
2. From the menu bar, select `File` → `Add Package Dependency`.
3. Enter the URL of the repository and add the dependency to your project.

### Manual Installation
1. Clone or download the repository code.
2. Add the necessary files to your project and configure them appropriately.

## Usage

### AquaButtonStyle
`AquaButtonStyle` customizes the appearance and behavior of SwiftUI buttons. It adjusts the button’s color, shadow, and shape, and includes visual feedback when the button is pressed.

**Example:**
```swift
Button("Press Me") {
    // Action
}
.aquaButtonStyle(aquaColor: .blue, colorShadow: true)
```

**Parameters:**
- `aquaColor`: The color applied to the button. This color is used for the button's frame and is visible when the button is in its normal state.
- `colorShadow`: A Boolean value that determines whether to apply a shadow effect to the button. If `true`, a shadow will be added for a more pronounced effect. Default value is true.
- `shape`: Defines the shape of the button. Options include `.capsule` (a rounded pill shape) and `.rectangle(cornerRadius: CGFloat)` (a rectangle with rounded corners). Default value is .capsule. 

**Note:** `AquaButtonStyle` is composed using `AquaFrameModifier` to apply the color, shadow, and shape styling.

### AquaToggleStyle
Use `AquaToggleStyle` to style SwiftUI toggles with either a toggle or push style. Customize the color and shape of the toggle switch.

**Example:**
```swift
Toggle("Toggle Option", isOn: $isOn)
.aquaToggle(style: .toggle, aquaColor: .green)
```

**Parameters:**
- `style`: The style of the toggle (`.toggle` or `.push`).
- `aquaColor`: The color applied to the toggle. Changes the appearance based on the toggle's state.
- `colorShadow`: A Boolean value to determine whether to apply a shadow effect. Default value is true. 

**Note:** `AquaToggleStyle` is also composed using `AquaFrameModifier` to handle the color, shadow, and shape styling.

### AquaFrameModifier
Use `AquaFrameModifier` to apply a custom frame and effects to any view. Adjust colors, opacity, shadow, and shape.

**Example:**
```swift
Text("Styled Text")
.aquaFrameModifier(aquaColor: .purple, aquaOpacity: 0.3, shape: .rectangle(cornerRadius: 10))
```

**Parameters:**
- `aquaColor`: The primary color applied to the frame.
- `aquaOpacity`: The opacity level of the frame's color. Default value is 0.5. 
- `colorShadow`: A Boolean value to determine whether to apply a shadow effect to the frame. Default value is true. 
- `shape`: The shape of the frame (`.capsule` or `.rectangle(cornerRadius: CGFloat)`).
