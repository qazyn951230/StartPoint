// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "StartPoint",
    platforms: [.macOS(.v10_14), .iOS(.v10)],
    products: [
        .library(name: "StartCore", targets: ["StartCore"]),
        .library(name: "StartPoint", targets: ["StartPoint"]),
    ],
    dependencies: [
        .package(url: "https://github.com/qazyn951230/RxSwift.git",
                 .revision("35f3bb6983f42921dce306d002ddb12dfb1fb7b2"))
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [],
            cxxSettings: [.unsafeFlags(["-std=c++17"])]),
        .target(
            name: "StartCore",
            dependencies: ["Core"]),
        .testTarget(
            name: "StartCoreTests",
            dependencies: ["StartCore"]),
        .target(
            name: "StartPoint",
            dependencies: ["StartCore", "RxSwift", "RxCocoa"]),
        .testTarget(
            name: "StartPointTests",
            dependencies: ["StartPoint"]),
    ]
)
