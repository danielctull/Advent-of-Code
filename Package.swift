// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Advent of Code",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_12),
        .tvOS(.v9),
        .watchOS(.v2),
    ],
    products: [
        .library(name: "Year2015", targets: ["Year2015"]),
        .library(name: "Year2018", targets: ["Year2018"]),
        .library(name: "Year2019", targets: ["Year2019"]),
        .library(name: "Year2020", targets: ["Year2020"]),
        .executable(name: "intcode", targets: ["IntcodeComputer tool"])
    ],
    dependencies: [
        .package(name: "swift-algorithms", url: "https://github.com/danielctull-forks/swift-algorithms.git", .branch("reductions")),
    ],
    targets: [

        // MARK: - Advent

        .target(
            name: "Advent",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
            ],
            path: "Advent/Sources"),

        .testTarget(
            name: "AdventTests",
            dependencies: ["Advent"],
            path: "Advent/Tests"),

        // MARK: - Year2015

        .target(
            name: "Year2015",
            dependencies: ["Advent"],
            path: "Year2015/Sources"),

        .testTarget(
            name: "Year2015Tests",
            dependencies: ["Advent", "Year2015"],
            path: "Year2015/Tests",
            resources: [.copy("Inputs")]),

        // MARK: - Year2018

        .target(
            name: "Year2018",
            dependencies: ["Advent"],
            path: "Year2018/Sources"),

        .testTarget(
            name: "Year2018Tests",
            dependencies: ["Advent", "Year2018"],
            path: "Year2018/Tests",
            resources: [.copy("Inputs")]),

        // MARK: - Year2019

        .target(
            name: "Year2019",
            dependencies: ["Advent"],
            path: "Year2019/Sources"),

        .testTarget(
            name: "Year2019Tests",
            dependencies: ["Advent", "Year2019"],
            path: "Year2019/Tests",
            resources: [.copy("Inputs")]),

        .target(
            name: "IntcodeComputer tool",
            dependencies: ["Advent", "Year2019"],
            path: "Year2019/IntcodeComputer tool"),

        // MARK: - Year2020

        .target(
            name: "Year2020",
            dependencies: ["Advent"],
            path: "Year2020/Sources"),

        .testTarget(
            name: "Year2020Tests",
            dependencies: ["Advent", "Year2020"],
            path: "Year2020/Tests",
            resources: [.copy("Inputs")]),
    ],
    swiftLanguageVersions: [.v5]
)
