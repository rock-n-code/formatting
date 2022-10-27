// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Formatting",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .plugin(
            name: "Formatting Plugins",
            targets: [
                "Dump Configuration"
            ]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-format.git",
            exact: "0.50700.1"
        )
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
               )
            ],
            path: "Plugins/DumpConfiguration"
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
