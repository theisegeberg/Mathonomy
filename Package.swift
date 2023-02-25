// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Mathonomy",
    platforms: [.macOS(.v12),.iOS(.v15)],
    products: [
        .library(name: "Mathonomy", targets: ["Mathonomy"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0")
    ],
    targets: [
        .target(name: "Mathonomy", dependencies: [
            .product(name: "Algorithms", package: "swift-algorithms")
        ]),
        .testTarget(
            name: "MathonomyTests",
            dependencies: ["Mathonomy"]),
    ]
)
