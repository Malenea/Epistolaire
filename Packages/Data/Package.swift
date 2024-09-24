// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Data",
            targets: ["Data"]
        ),
        .library(
            name: "DataProtocols",
            targets: ["DataProtocols"]
        ),
        .library(
            name: "DataMocks",
            targets: ["DataMocks"]
        ),
    ],
    targets: [
        .target(
            name: "Data",
            resources: [
                .process("Resources"),
            ]
        ),
        .target(
            name: "DataProtocols"
        ),
        .target(
            name: "DataMocks",
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: [
                "Data",
                "DataProtocols",
                "DataMocks"
            ]
        ),
    ]
)
