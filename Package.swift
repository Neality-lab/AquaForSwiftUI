// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AquaForSwiftUI",
    platforms: [.iOS(.v17)],
    products: [ // `products` specifies what the package provides for external use (libraries or binaries).
        .library(
            name: "AquaForSwiftUI",
            targets: ["AquaForSwiftUI"]),
    ],
    dependencies: [],
    targets: [ // `targets` defines the internal modules and their dependencies used for building the package.
        // Library target
        .target(
            name: "AquaForSwiftUI", // Name of the target
            dependencies: ["AquaForSwiftUI"] // Other targets or external packages this target depends on
        ),
        
        // Test target
        .testTarget(
            name: "AquaForSwiftUITests", // Name of the test target
            dependencies: ["AquaForSwiftUI"] // Specify the target to be tested
        ),
    ]
)
