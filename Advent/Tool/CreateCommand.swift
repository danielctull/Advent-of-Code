
import ArgumentParser
import FileBuilder
import Foundation

struct CreateCommand: ParsableCommand {

    @Argument(help: "The year.")
    var year: Int = { Calendar.gregorian.value(for: .year, from: Date()) }()

    @Argument(help: "The day.")
    var day: Int = { Calendar.gregorian.value(for: .day, from: Date()) }()

    private var dayString: String { "Day" + String(format: "%02d", day) }
    private var yearString: String { "Year\(year)" }

    private var currentDirectory: URL { URL(fileURLWithPath: FileManager().currentDirectoryPath) }

    static var configuration: CommandConfiguration {
        CommandConfiguration(commandName: "create")
    }

    func run() throws {

        try Directory("Year\(year)") {
            Directory("Sources") {
                SourceFile(day: dayString)
            }
            Directory("Tests") {
                TestFile(day: dayString, year: yearString)
                Directory("Inputs") {
                    InputFile(day: dayString)
                }
            }
        }
        .write(in: currentDirectory)
    }
}

private struct SourceFile: File {

    let day: String

    var body: some File {
        TextFile(day + ".swift") {
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

    let day: String
    let year: String

    var body: some File {
        TextFile(day + "Tests.swift") {
            """

            import Advent
            import Year\(year)
            import XCTest

            final class DayDDTests: XCTestCase {

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

    let day: String

    var body: some File {
        TextFile(day + ".txt") {
            ""
        }
    }
}

extension Calendar {

    static let gregorian = Self(identifier: .gregorian)

    func value(for component: Calendar.Component, from date: Date) -> Int {
        dateComponents([component], from: date).value(for: component)!
    }
}
