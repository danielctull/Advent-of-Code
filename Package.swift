// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Advent of Code",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_13),
        .tvOS(.v9),
        .watchOS(.v2),
    ],
    products: [
        .library(name: "Advent", targets: ["Advent"]),
        .library(name: "Year2015", targets: ["Year2015"]),
        .library(name: "Year2018", targets: ["Year2018"]),
        .library(name: "Year2019", targets: ["Year2019"]),
        .library(name: "Year2020", targets: ["Year2020"]),
        .library(name: "Year2021", targets: ["Year2021"]),
        .executable(name: "aoc", targets: ["AdventTool"]),
        .executable(name: "intcode", targets: ["IntcodeComputer tool"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms.git", from: "0.0.4"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "0.3.1"),
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

        .target(
            name: "AdventTool",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Advent",
                "Year2015",
                "Year2018",
                "Year2019",
                "Year2020",
            ],
            path: "Advent/Tool",
            resources: [.copy("Templates")]),

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

        // MARK: - Year2021

        .target(
            name: "Year2021",
            dependencies: ["Advent"],
            path: "Year2021/Sources"),

        .testTarget(
            name: "Year2021Tests",
            dependencies: ["Advent", "Year2019", "Year2021"],
            path: "Year2021/Tests",
            resources: [.copy("Inputs")]),
    ],
    swiftLanguageVersions: [.v5]
)
