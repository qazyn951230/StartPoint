// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "StartPoint",
    dependencies: [],
    targets: [
        .target(
            name: "StartCore",
            dependencies: []),
        .testTarget(
            name: "StartCoreTests",
            dependencies: ["StartCore"]),
        .target(
            name: "StartPoint",
            dependencies: ["StartCore"]),
        .testTarget(
            name: "StartPointTests",
            dependencies: ["StartPoint"]),
    ]
)
