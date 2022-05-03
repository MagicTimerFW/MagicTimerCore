// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MagicTimerCore",
    platforms: [.iOS("11.0")],
    products: [
        .library(
            name: "MagicTimerCore",
            targets: ["MagicTimerCore"]),
    ],
    dependencies: [
        .package(name: "MagicTimerCommon", url: "https://github.com/MagicTimerFW/MagicTimerCommon.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "MagicTimerCore",
            dependencies: [
                .product(name: "MagicTimerCommon", package: "MagicTimerCommon")
            ]),
        .testTarget(
            name: "MagicTimerCoreTests",
            dependencies: ["MagicTimerCore"]),
    ]
)
