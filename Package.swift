// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Formatting",
    platforms: [
        .macOS(.v11),
        .macCatalyst(.v14),
        .iOS(.v14),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .plugin(
            name: "Formatting Plugins",
            targets: [
                "Dump Configuration",
                "Format Source Code",
                "Lint Source Code"
            ]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-format.git",
            exact: "0.50700.1"
        ),
    ],
    targets: [
        .plugin(
            name: "Dump Configuration",
            capability: .command(
                intent: .custom(
                    verb: "dump-configuration",
                    description: "Add or reset a Swift Format configuration file named as \".swift-format.json\" with default settings."
                ),
                permissions: [
                    .writeToPackageDirectory(reason: "Add or reset a .swift-format.json configuration file with default settings.")
                ]
            ),
            dependencies: [
               .product(
                    name: "swift-format",
                    package: "swift-format"
               ),
            ],
            path: "Plugins/DumpConfiguration"
        ),
        .plugin(
            name: "Format Source Code",
            capability: .command(
                intent: .sourceCodeFormatting(),
                permissions: [
                    .writeToPackageDirectory(reason: "Format source code using swift-format.")
                ]
            ),
            dependencies: [
                .product(
                    name: "swift-format",
                    package: "swift-format"
                ),
            ],
            path: "Plugins/FormatSourceCode"
        ),
        .plugin(
            name: "Lint Source Code",
            capability: .command(
                intent: .custom(
                    verb: "lint-source-code",
                    description: "Lint source code using swift-format."
                )
            ),
            dependencies: [
                .product(
                    name: "swift-format",
                    package: "swift-format"
                ),
            ],
            path: "Plugins/LintSourceCode"
        ),
        .target(
            name: "FormattingCore",
            path: "Sources/Formatting"
        ),
        .testTarget(
            name: "FormattingCoreTests",
            dependencies: ["FormattingCore"],
            path: "Tests/Formatting"
        )
    ]
)
