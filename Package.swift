// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Formatting",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .plugin(
            name: "Formatting Plugins",
            targets: [
                "Reset Configuration"
            ]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-format.git",
            from: "0.50700.1"
        )
    ],
    targets: [
        .plugin(
            name: "Reset Configuration",
            capability: .command(
                intent: .custom(
                    verb: "reset-configuration",
                    description: "Add or reset a .swift-format.json with Swift Format default configuration."
                ),
                permissions: [
                    .writeToPackageDirectory(reason: "Add a default .swift-format.json file with default configuration.")
                ]
            ),
            dependencies: [
               .product(
                    name: "swift-format",
                    package: "swift-format"
               )
            ],
            path: "Plugins/ResetConfiguration"
        ),
        .target(
            name: "FormattingCore",
            path: "Sources/Formatting"
        ),
        .testTarget(
            name: "FormattingCoreTests",
            dependencies: [
                "FormattingCore"
            ],
            path: "Tests/Formatting"
        )
    ]
)
