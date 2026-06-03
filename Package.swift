// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-byte-collection-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(
            name: "Byte Collection Primitives",
            targets: ["Byte Collection Primitives"]
        ),
        .library(
            name: "Byte Collection Primitives Test Support",
            targets: ["Byte Collection Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-byte-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-collection-primitives.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Byte Collection Primitives Standard Library Integration",
            dependencies: [
                .product(name: "Byte Primitives", package: "swift-byte-primitives"),
                .product(name: "Collection Protocol Primitives", package: "swift-collection-primitives"),
            ]
        ),
        .target(
            name: "Byte Collection Primitives",
            dependencies: [
                "Byte Collection Primitives Standard Library Integration",
            ]
        ),
        .target(
            name: "Byte Collection Primitives Test Support",
            dependencies: [
                "Byte Collection Primitives",
                .product(name: "Byte Primitives Test Support", package: "swift-byte-primitives"),
                .product(name: "Collection Primitives Test Support", package: "swift-collection-primitives"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Byte Collection Primitives Tests",
            dependencies: [
                "Byte Collection Primitives",
                "Byte Collection Primitives Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
