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
        .executable(name: "intcode", targets: ["IntcodeComputer tool"])
    ],
    targets: [

        // MARK: - Advent

        .target(
            name: "Advent",
            path: "Advent"),

        // MARK: - Year2015

        .target(
            name: "Year2015",
            dependencies: ["Advent"],
            path: "Year2015/Sources"),

        .testTarget(
            name: "Year2015 Tests",
            dependencies: ["Advent", "Year2015"],
            path: "Year2015/Tests",
            resources: [.copy("Inputs")]),

        // MARK: - Year2018

        .target(
            name: "Year2018",
            dependencies: ["Advent"],
            path: "Year2018/Sources"),

        .testTarget(
            name: "Year2018 Tests",
            dependencies: ["Advent", "Year2018"],
            path: "Year2018/Tests",
            resources: [.copy("Inputs")]),

        // MARK: - Year2019

        .target(
            name: "Year2019",
            dependencies: ["Advent"],
            path: "Year2019/Sources"),

        .testTarget(
            name: "Year2019 Tests",
            dependencies: ["Advent", "Year2019"],
            path: "Year2019/Tests",
            resources: [.copy("Inputs")]),

        .target(
            name: "IntcodeComputer tool",
            dependencies: ["Advent", "Year2019"],
            path: "Year2019/IntcodeComputer tool"),
    ],
    swiftLanguageVersions: [.v5]
)
