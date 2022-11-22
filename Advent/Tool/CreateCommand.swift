
import ArgumentParser
import FileBuilder
import Foundation

struct CreateCommand: ParsableCommand {

    @Argument(help: "The year.")
    var year: Year = .current

    @Argument(help: "The day.")
    var day: Day = .current

    static var configuration: CommandConfiguration {
        CommandConfiguration(commandName: "create")
    }

    func run() throws {

        try Directory("\(year)") {
            Directory("Sources") {
                SourceFile(day: day)
            }
            Directory("Tests") {
                TestFile(day: day, year: year)
                Directory("Inputs") {
                    InputFile(day: day)
                }
            }
        }
        .write(in: FileManager().currentDirectory)
    }
}

// MARK: - Files

private struct SourceFile: File {

    let day: CreateCommand.Day

    var body: some File {
        TextFile("\(day).swift") {
            """

            import Advent
            import Algorithms
            import Foundation

            public enum \(day): Day {

                public static let title = ""

                public static func part1(_ input: Input) throws -> Int {
                    0
                }

                public static func part2(_ input: Input) throws -> Int {
                    0
                }
            }
            """
        }
    }
}

private struct TestFile: File {

    let day: CreateCommand.Day
    let year: CreateCommand.Year

    var body: some File {
        TextFile("\(day)Tests.swift") {
            """

            import Advent
            import \(year)
            import XCTest

            final class \(day)Tests: XCTestCase {

                func testPart1Examples() throws {
                    XCTAssertEqual(try \(day).part1([]), 0)
                }

                func testPart1Puzzle() throws {
                    let input = try Bundle.module.input(named: "\(day)")
                    XCTAssertEqual(try \(day).part1(input), 0)
                }

                func testPart2Examples() throws {
                    XCTAssertEqual(try \(day).part2([]), 0)
                }

                func testPart2Puzzle() throws {
                    let input = try Bundle.module.input(named: "\(day)")
                    XCTAssertEqual(try \(day).part2(input), 0)
                }
            }
            """
        }
    }
}

private struct InputFile: File {

    let day: CreateCommand.Day

    var body: some File {
        TextFile("\(day).txt") {
            ""
        }
    }
}

// MARK: - Day

extension CreateCommand {

    struct Day {
        fileprivate let value: Int
    }
}

extension CreateCommand.Day {

    static var current: Self {
        Self(value: Calendar.gregorian.value(for: .day, from: Date()))
    }
}

extension CreateCommand.Day: ExpressibleByArgument {

    init?(argument: String) {
        guard let value = Int(argument: argument) else { return nil }
        self.value = value
    }
}

extension String.StringInterpolation {

    mutating func appendInterpolation(_ day: CreateCommand.Day) {
        appendInterpolation("Day" + String(format: "%02d", day.value))
    }
}

// MARK: - Year

extension CreateCommand {

    struct Year {
        fileprivate let value: Int
    }
}

extension CreateCommand.Year {

    static var current: Self {
        Self(value: Calendar.gregorian.value(for: .year, from: Date()))
    }
}

extension CreateCommand.Year: ExpressibleByArgument {

    init?(argument: String) {
        guard let value = Int(argument: argument) else { return nil }
        self.value = value
    }
}

extension String.StringInterpolation {

    mutating func appendInterpolation(_ year: CreateCommand.Year) {
        appendInterpolation("Year\(year.value)")
    }
}

// MARK: - Calendar

extension Calendar {

    static let gregorian = Self(identifier: .gregorian)

    func value(for component: Calendar.Component, from date: Date) -> Int {
        dateComponents([component], from: date).value(for: component)!
    }
}

// MARK: - FileManager

extension FileManager {

    fileprivate var currentDirectory: URL {
        URL(fileURLWithPath: currentDirectoryPath)
    }
}
