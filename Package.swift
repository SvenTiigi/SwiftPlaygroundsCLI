// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "SwiftPlaygroundsCLI",
    products: [
        // The SwiftPlaygroundsCLI executable
        .executable(
            name: "swiftplaygrounds",
            targets: ["SwiftPlaygroundsCLI"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/jakeheis/SwiftCLI.git", .exact("6.0.1"))
    ],
    targets: [
        .target(
            name: "SwiftPlaygroundsCLI",
            dependencies: [
                "SwiftCLI"
            ]
        ),
        .testTarget(
            name: "SwiftPlaygroundsCLITests",
            dependencies: [
                "SwiftPlaygroundsCLI"
            ]
        )
    ]
)
