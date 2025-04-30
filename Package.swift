// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HeterogeneousBoxPackage",
    platforms: [
        .macOS(.v14),
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "HeterogeneousBox",
            targets: ["HeterogeneousBox"]
        )
    ],
    targets: [
        .executableTarget(
            name: "HeterogeneousBoxClient",
            dependencies: ["HeterogeneousBox"]
        ),
        .target(
            name: "HeterogeneousBox"
        ),
        .testTarget(
            name: "HeterogeneousBoxTests",
            dependencies: ["HeterogeneousBox"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
