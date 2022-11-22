
import ArgumentParser
import FileBuilder
import Foundation

struct CreateCommand: ParsableCommand {

    @Argument(help: "The year.")
    var year: Int = { Calendar.gregorian.value(for: .year, from: Date()) }()

    @Argument(help: "The day.")
    var day: Int = { Calendar.gregorian.value(for: .day, from: Date()) }()

    private var dayString: String { String(format: "%02d", day) }

    private var currentDirectory: URL { URL(fileURLWithPath: FileManager().currentDirectoryPath) }

    static var configuration: CommandConfiguration {
        CommandConfiguration(commandName: "create")
    }

    func run() throws {

        try Directory("Year\(year)") {

            Directory("Sources") {
                TextFile("Day\(dayString).swift") {
                    """

                    import Advent
                    import Algorithms
                    import Foundation

                    public enum Day\(dayString): Day {

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

            Directory("Tests") {

                Directory("Inputs") {
                    TextFile("Day\(dayString).txt") {
                        ""
                    }
                }

                TextFile("Day\(dayString)Tests.swift") {
                    """

                    import Advent
                    import Year\(year)
                    import XCTest

                    final class DayDDTests: XCTestCase {

                        func testPart1Examples() throws {
                            XCTAssertEqual(try Day\(dayString).part1([]), 0)
                        }

                        func testPart1Puzzle() throws {
                            let input = try Bundle.module.input(named: "Day\(dayString)")
                            XCTAssertEqual(try Day\(dayString).part1(input), 0)
                        }

                        func testPart2Examples() throws {
                            XCTAssertEqual(try Day\(dayString).part2([]), 0)
                        }

                        func testPart2Puzzle() throws {
                            let input = try Bundle.module.input(named: "Day\(dayString)")
                            XCTAssertEqual(try Day\(dayString).part2(input), 0)
                        }
                    }
                    """
                }
            }
        }.write(in: currentDirectory)
    }
}

extension Calendar {

    static let gregorian = Self(identifier: .gregorian)

    func value(for component: Calendar.Component, from date: Date) -> Int {
        dateComponents([component], from: date).value(for: component)!
    }
}
