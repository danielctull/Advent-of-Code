// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Advent of Code",
	platforms: [
		.iOS(.v9),
		.macOS(.v10_12),
		.tvOS(.v9),
		.watchOS(.v2),
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
			dependencies: ["Year2015"],
			path: "Year2015/Tests"),

		// MARK: - Year2018

		.target(
			name: "Year2018",
			dependencies: ["Advent"],
			path: "Year2018/Source"),

		.testTarget(
			name: "Year2018 Tests",
			dependencies: ["Year2018"],
			path: "Year2018/Tests"),
	],
	swiftLanguageVersions: [.v5]
)
