// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NSCoder_tvOS_Domain",
    platforms: [.macOS(.v15), .iOS(.v18), .tvOS(.v18)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NSCoder_tvOS_Domain",
            targets: ["NSCoder_tvOS_Domain"]),
    ],
    dependencies: [
        .package(path: "../UnsplashApi")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NSCoder_tvOS_Domain",
            dependencies: ["UnsplashApi"]
        ),
        .testTarget(
            name: "NSCoder_tvOS_DomainTests",
            dependencies: ["NSCoder_tvOS_Domain"],
            resources: [.copy("Mocks/MockPhotos.json")]
        ),
    ]
)
