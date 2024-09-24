// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Messaging",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Messaging",
            targets: [
                "Messaging"
            ]
        ),
    ],
    dependencies: [
        // Third-party libs
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.10.0"),

        // Local packages
        .package(path: "../Domain"),
        .package(path: "../Shared"),
        .package(path: "../Data"),
    ],
    targets: [
        .target(
            name: "Messaging",
            dependencies: [
                // Local packages
                .product(name: "Domain", package: "Domain"),
                .product(name: "Shared", package: "Shared"),
                .product(name: "DataProtocols", package: "Data"),
            ]
        ),
        .testTarget(
            name: "MessagingTests",
            dependencies: [
                "Messaging",

                // Third-party libs
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),

                // Local packages
                .product(name: "Domain", package: "Domain"),
                .product(name: "DataMocks", package: "Data"),
            ]
        ),
    ]
)
