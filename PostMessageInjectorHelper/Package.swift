// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PostMessageInjectorHelper",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "PostMessageInjectorHelper",
            targets: ["PostMessageInjectorHelper"]),
    ],
    targets: [
        .target(
            name: "PostMessageInjectorHelper"),
        
        .testTarget(
            name: "PostMessageInjectorHelperTests",
            dependencies: [
                "PostMessageInjectorHelper"
            ]
        )
    ]
)
