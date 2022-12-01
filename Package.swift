// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Advent of Code",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        .library(name: "Advent", targets: ["Advent"]),
        .library(name: "Year2015", targets: ["Year2015"]),
        .library(name: "Year2016", targets: ["Year2016"]),
        .library(name: "Year2018", targets: ["Year2018"]),
        .library(name: "Year2019", targets: ["Year2019"]),
        .library(name: "Year2020", targets: ["Year2020"]),
        .library(name: "Year2021", targets: ["Year2021"]),
        .library(name: "Year2022", targets: ["Year2022"]),
        .executable(name: "aoc", targets: ["AdventTool"]),
        .executable(name: "intcode", targets: ["IntcodeComputer tool"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "0.0.4"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
        .package(url: "https://github.com/apple/swift-crypto", from: "2.2.0"),
        .package(url: "https://github.com/danielctull/FileBuilder", branch: "main"),
        .package(url: "https://github.com/danielctull/KeychainItem", branch: "main"),
    ],
    targets: [

        // MARK: - Advent

        .target(
            name: "Advent",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Crypto", package: "swift-crypto"),
            ],
            path: "Advent/Sources",
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        .testTarget(
            name: "AdventTests",
            dependencies: ["Advent"],
            path: "Advent/Tests",
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        .executableTarget(
            name: "AdventTool",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "FileBuilder", package: "FileBuilder"),
                "KeychainItem",
                "Advent",
                "Year2015",
                "Year2018",
                "Year2019",
                "Year2020",
            ],
            path: "Advent/Tool",
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        // MARK: - Year2015

        .target(
            name: "Year2015",
            dependencies: ["Advent"],
            path: "Year2015/Sources",
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        .testTarget(
            name: "Year2015Tests",
            dependencies: ["Advent", "Year2015"],
            path: "Year2015/Tests",
            resources: [.copy("Inputs")],
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        // MARK: - Year2016

        .target(
            name: "Year2016",
            dependencies: ["Advent"],
            path: "Year2016/Sources",
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        .testTarget(
            name: "Year2016Tests",
            dependencies: ["Advent", "Year2016"],
            path: "Year2016/Tests",
            resources: [.copy("Inputs")],
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        // MARK: - Year2018

        .target(
            name: "Year2018",
            dependencies: ["Advent"],
            path: "Year2018/Sources",
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        .testTarget(
            name: "Year2018Tests",
            dependencies: ["Advent", "Year2018"],
            path: "Year2018/Tests",
            resources: [.copy("Inputs")],
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        // MARK: - Year2019

        .target(
            name: "Year2019",
            dependencies: ["Advent"],
            path: "Year2019/Sources",
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        .testTarget(
            name: "Year2019Tests",
            dependencies: ["Advent", "Year2019"],
            path: "Year2019/Tests",
            resources: [.copy("Inputs")],
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        .executableTarget(
            name: "IntcodeComputer tool",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Advent",
                "Year2019",
            ],
            path: "Year2019/IntcodeComputer tool",
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        // MARK: - Year2020

        .target(
            name: "Year2020",
            dependencies: ["Advent"],
            path: "Year2020/Sources",
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        .testTarget(
            name: "Year2020Tests",
            dependencies: ["Advent", "Year2020"],
            path: "Year2020/Tests",
            resources: [.copy("Inputs")],
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        // MARK: - Year2021

        .target(
            name: "Year2021",
            dependencies: ["Advent"],
            path: "Year2021/Sources",
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        .testTarget(
            name: "Year2021Tests",
            dependencies: ["Advent", "Year2019", "Year2021"],
            path: "Year2021/Tests",
            resources: [.copy("Inputs")],
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        // MARK: - Year2022

        .target(
            name: "Year2022",
            dependencies: ["Advent"],
            path: "Year2022/Sources",
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),

        .testTarget(
            name: "Year2022Tests",
            dependencies: ["Advent", "Year2022"],
            path: "Year2022/Tests",
            resources: [.copy("Inputs")],
            swiftSettings: [
                .unsafeFlags(["-enable-bare-slash-regex"]),
            ]),
    ],
    swiftLanguageVersions: [.v5]
)
