// swift-tools-version:5.1

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
			path: "Year2015/Source"),

		.testTarget(
			name: "Year2015 Tests",
			dependencies: ["Advent", "Year2015"],
			path: "Year2015/Tests"),

		// MARK: - Year2018

		.target(
			name: "Year2018",
			dependencies: ["Advent"],
			path: "Year2018/Source"),

		.testTarget(
			name: "Year2018 Tests",
			dependencies: ["Advent", "Year2018"],
			path: "Year2018/Tests"),

        // MARK: - Year2019

        .target(
            name: "Year2019",
            dependencies: ["Advent"],
            path: "Year2019/Source"),

        .testTarget(
            name: "Year2019 Tests",
            dependencies: ["Advent", "Year2018"],
            path: "Year2019/Tests"),

        .target(
            name: "IntcodeComputer tool",
            dependencies: ["Advent", "Year2019"],
            path: "Year2019/IntcodeComputer tool"),
	],
	swiftLanguageVersions: [.v5]
)
