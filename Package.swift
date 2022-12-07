// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GOONetwork",
    platforms: [
        .iOS(.v13),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "GOONetwork",
            targets: ["GOONetwork"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "GOONetwork",
            dependencies: []),
        .testTarget(
            name: "GOONetworkTests",
            dependencies: ["GOONetwork"]),
    ]
)
