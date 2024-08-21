// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RemForm",
    platforms: [
        .macOS(.v15),
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "RemForm",
            targets: ["RemForm"]),
    ],
    dependencies: [
        .package(url: "https://github.com/NoahKamara/Natural", branch: "main")
    ],
    targets: [
        .target(
            name: "RemForm",
            dependencies: ["Natural"]
        ),

    ]
)
