// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Mathonomy",
    platforms: [.macOS(.v12),.iOS(.v15)],
    products: [
        .library(name: "Mathonomy", targets: ["Mathonomy"]),
    ],
    dependencies: [
        .package(url: "git@github.com:apple/swift-algorithms.git", from: "1.2.0"),
        .package(url: "git@github.com:apple/swift-numerics.git", from: "1.0.2")
    ],
    targets: [
        .target(name: "Mathonomy", dependencies: [
            .product(name: "Algorithms", package: "swift-algorithms"),
            .product(name: "Numerics", package: "swift-numerics")
        ]),
        .testTarget(
            name: "MathonomyTests",
            dependencies: ["Mathonomy"]),
    ]
)
