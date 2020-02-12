// swift-tools-version:5.1

import PackageDescription

// SwiftPlaygroundsCLI Package
let package = Package(
    name: "SwiftPlaygroundsCLI",
    products: [
        // SwiftPlayground Executable
        .executable(
            name: "swiftplayground",
            targets: ["SwiftPlaygroundsCLI"]
        ),
        /// SwiftPlaygroundsKit Framework
        .library(
            name: "SwiftPlaygroundsKit",
            targets: ["SwiftPlaygroundsKit"]
        )
    ],
    dependencies: [
        // SwiftCLI Dependency
        .package(url: "https://github.com/jakeheis/SwiftCLI.git", .exact("6.0.1"))
    ],
    targets: [
        // SwiftPlaygroundCLI Target
        .target(
            name: "SwiftPlaygroundsCLI",
            dependencies: [
                "SwiftCLI",
                "SwiftPlaygroundsKit"
            ]
        ),
        // SwiftPlaygroundsKit Target
        .target(
            name: "SwiftPlaygroundsKit",
            dependencies: []
        ),
        // SwiftPlaygroundsCLI Test Target
        .testTarget(
            name: "SwiftPlaygroundsCLITests",
            dependencies: [
                "SwiftPlaygroundsCLI"
            ]
        )
    ]
)
