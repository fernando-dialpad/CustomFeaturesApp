// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Root",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Root",
            targets: ["Root"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", branch: "main"),
        .package(path: "../SharedModels"),
        .package(path: "../Network"),
        .package(path: "../Core"),
        .package(path: "../ContactHeader"),
        .package(path: "../ContactList"),
        .package(path: "../Settings"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Root",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "SharedModels", package: "SharedModels"),
                .product(name: "Network", package: "Network"),
                .product(name: "Core", package: "Core"),
                .product(name: "ContactHeader", package: "ContactHeader"),
                .product(name: "ContactList", package: "ContactList"),
                .product(name: "Settings", package: "Settings")
            ]
        ),
        .testTarget(
            name: "RootTests",
            dependencies: ["Root"]
        ),
    ]
)


