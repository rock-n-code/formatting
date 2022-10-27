# Formatting source code plugin for Swift (and Xcode)

`formatting` provides simplified source formatting features for any Swift source code as focused plugins to both the [Swift programming language](https://www.swift.org) compiler and to the [Xcode](https://www.swift.org) IDE from [Apple](https://www.apple.com).

These plugins are distributed as a [Swift Package Manager](https://www.swift.org/package-manager/) (or SPM) package that you can add as a dependency in any kind of Swift-based project.

This package relies heavily on the source formatting tools provided by the [`swift-format`](https://github.com/apple/swift-format) dependency, which means that these plugins also follows the Swift compiler and Xcode version meticulously.

## Installation

It is possible to add this dependency in the `Package.swift` file if available or inside the **Package dependencies** section in any project generated using Xcode.

Below there is an example of how to add this package as a dependency in a `library`/`executable` project generated with the Swift compiler:

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

## Known issues

In case of using these plugins within the Xcode IDE, it is possible to encounter the following issue: 

```
dyld[68577]: Library not loaded: @rpath/lib_InternalSwiftSyntaxParser.dylib
  Referenced from: <17E5E859-51EB-314D-AA59-E3BA66F2E000> /Users/logan/Library/Developer/Xcode/DerivedData/MyTraining-adcdxmalfkxepzbacazacvalqkwg/Build/Products/Debug/swift-format
  Reason: tried: '/usr/lib/swift/lib_InternalSwiftSyntaxParser.dylib' (no such file, not in dyld cache), '/System/Volumes/Preboot/Cryptexes/OS/usr/lib/swift/lib_InternalSwiftSyntaxParser.dylib' (no such file), '/usr/lib/swift/lib_InternalSwiftSyntaxParser.dylib' (no such file, not in dyld cache), '/System/Volumes/Preboot/Cryptexes/OS/usr/lib/swift/lib_InternalSwiftSyntaxParser.dylib' (no such file), '/System/Volumes/Preboot/Cryptexes/OS@rpath/lib_InternalSwiftSyntaxParser.dylib' (no such file), '/usr/lib/swift/lib_InternalSwiftSyntaxParser.dylib' (no such file, not in dyld cache), '/System/Volumes/Preboot/Cryptexes/OS/usr/lib/swift/lib_InternalSwiftSyntaxParser.dylib' (no such file), '/usr/lib/swift/lib_InternalSwiftSyntaxParser.dylib' (no such file, not in dyld cache), '/System/Volumes/Preboot/Cryptexes/OS/usr/lib/swift/lib_InternalSwiftSyntaxParser.dylib' (no such file), '/usr/local/lib/lib_InternalSwiftSyntaxParser.dylib' (no such file), '/usr/lib/lib_InternalSwiftSyntaxParser.dylib' (no such file, not in dyld cache)
runNotSuccessful(reason: __C.NSTaskTerminationReason, status: 6)
```

One workaround to solve this issue is to copy the mentioned dynamic library (`lib_InternalSwiftSyntaxParser.dylib`) to one of the folders  that are mentioned in the log right above this paragraph.

The following CLI command example resolves the issue:

```zsh
cp "$(xcode-select -p)"/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx/lib_InternalSwiftSyntaxParser.dylib /usr/local/lib

```

It is possible that the use of the `sudo` command to execute this operation is required.