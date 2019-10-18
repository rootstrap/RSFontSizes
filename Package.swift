// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "RSFontSizes",
    platforms: [
        .iOS("8.3")
    ],
    products: [
        .library(
            name: "RSFontSizes",
            targets: ["RSFontSizes"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Ekhoo/Device.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "RSFontSizes",
            dependencies: ["Device"],
            path: "RSFontSizes/Classes"),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
