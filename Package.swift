// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Formatting",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .plugin(
            name: "Formatting Plugins",
            targets: [
                "Format Source Code"
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
            name: "Format Source Code",
            capability: .command(
                intent: .sourceCodeFormatting(),
                permissions: [
                    .writeToPackageDirectory(
                        reason: "..."
                    )
                ]
            ),
            dependencies: [
                "Formatting",
                .product(
                    name: "SwiftFormat",
                    package: "swift-format"
                )
            ],
            path: "Plugins/FormatSourceCode"
        ),
        .target(
            name: "Formatting",
            dependencies: []
        ),
        .testTarget(
            name: "FormattingTests",
            dependencies: [
                "Formatting"
            ]
        ),
    ]
)
