// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Domain",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Domain",
            targets: [
                "Domain"
            ]
        ),
    ],
    dependencies: [
        // Local packages
        .package(path: "../Data"),
        .package(path: "../Shared"),
    ],
    targets: [
        .target(
            name: "Domain",
            dependencies: [
                // Local packages
                .product(name: "Data", package: "Data"),
                .product(name: "Shared", package: "Shared"),
            ]
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: [
                "Domain"
            ]
        ),
    ]
)
