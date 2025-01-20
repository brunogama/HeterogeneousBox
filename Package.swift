// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VariadicBox",
    platforms: [
        .macOS(.v14),
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "VariadicBox",
            targets: ["VariadicBox"]
        ),
        .executable(
            name: "VariadicBoxClient",
            targets: ["VariadicBoxClient"]
        )
    ],
    targets: [
        .target(
            name: "VariadicBox"
        ),
        .executableTarget(
            name: "VariadicBoxClient",
            dependencies: [
                "VariadicBox"
            ]
        ),
        .testTarget(
            name: "VariadicBoxTests",
            dependencies: [
                "VariadicBox"
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
