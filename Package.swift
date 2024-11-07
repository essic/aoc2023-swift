// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "aoc2023-swift",
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms.git", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "aoc2023-swift", dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms")
            ]),
    ]
)
