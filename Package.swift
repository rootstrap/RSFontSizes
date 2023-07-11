// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RSFontSizes",
    products: [
        .library(
            name: "RSFontSizes",
            targets: ["RSFontSizes"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Ekhoo/Device.git", from: "3.3.0")
    ],
    targets: [
        .target(
            name: "RSFontSizes",
            dependencies: ["Device"],
            path: "Sources"),
        .testTarget(
            name: "RSFontSizesTests",
            dependencies: ["RSFontSizes"]),
    ]
)
