# Formatting source code plugin for Swift (and Xcode)

`formatting` provides simplified source formatting features for any Swift source code as focused plugins to both the [Swift programming language](https://www.swift.org) compiler and to the [Xcode](https://www.swift.org) IDE from [Apple](https://www.apple.com).

These plugins are distributed as a [Swift Package Manager](https://www.swift.org/package-manager/) (or SPM) package that you can add as a dependency in any kind of Swift-based project.

This package relies heavily on the source formatting tools provided by the [`swift-format`](https://github.com/apple/swift-format) dependency, which means that these plugins also follows the Swift compiler and Xcode version meticulously.

## Installation

It is possible to add this dependency in the `Package.swift` file if available or inside the **Package dependencies** section in the Xcode project.

```swift
let package = Package(
    // ...
    dependencies: [
        .package(
            url: "https://github.com/rock-n-code/formatting.git",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "YourLibrary",
            dependencies: [
                .product(
                    name: "Formatting",
                    package: "formatting"
                )
            ],
            plugins: [
                "Format Source Code"
            ]
        ),
    ],
    // ...
)
```
