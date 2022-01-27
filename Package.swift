// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "StartPoint",
    products: [
        .library(
            name: "StartCxx",
            targets: ["StartCxx"]),
        .library(
            name: "StartPoint",
            targets: ["StartPoint"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "StartCxx",
            exclude: [
                "CMakeLists.txt",
            ]),
        .target(name: "StartPoint"),
        .testTarget(
            name: "StartPointTests",
            dependencies: [
                "StartPoint",
            ]),
    ],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx20
)
