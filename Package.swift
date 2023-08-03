swift-tools-version: 5.7.1

import PackageDescription

let package = Package(
    name: "RSFontSizes",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "RSFontSizes",
            targets: ["RSFontSizes"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Ekhoo/Device.git", from: "3.5.0")
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
